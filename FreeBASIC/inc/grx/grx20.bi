''
''
'' grx20 -- 2D graphics library (header translated with help of SWIG FB wrapper)
''
'' NOTICE: This file is part of the FreeBASIC Compiler package and can't
''         be included in other distributions without authorization.
''
''
#ifndef __grx20_bi__
#define __grx20_bi__

#inclib "grx20"

#ifdef __FB_WIN32__
#inclib "gdi32"
#inclib "user32"
#endif

#define GRX_VERSION_API &h0246
#define GRX_VERSION_TCC_8086_DOS 1
#define GRX_VERSION_GCC_386_GO32 2
#define GRX_VERSION_GCC_386_DJGPP 2
#define GRX_VERSION_GCC_386_LINUX 3
#define GRX_VERSION_GENERIC_X11 4
#define GRX_VERSION_WATCOM_DOS4GW 5
#define GRX_VERSION_GCC_386_WIN32 7
#define GRX_VERSION_MSC_386_WIN32 8
#define GRX_VERSION_GCC_386_CYG32 9

type GrFrameDriver as _GR_frameDriver
type GrVideoDriver as _GR_videoDriver
type GrVideoMode as _GR_videoMode
type GrVideoModeExt as _GR_videoModeExt
type GrFrame as _GR_frame
type GrContext as _GR_context
type GrColor as uinteger

enum _GR_graphicsModes
	GR_unknown_mode = (-1)
	GR_80_25_text = 0
	GR_default_text
	GR_width_height_text
	GR_biggest_text
	GR_320_200_graphics
	GR_default_graphics
	GR_width_height_graphics
	GR_biggest_noninterlaced_graphics
	GR_biggest_graphics
	GR_width_height_color_graphics
	GR_width_height_color_text
	GR_custom_graphics
	GR_NC_80_25_text
	GR_NC_default_text
	GR_NC_width_height_text
	GR_NC_biggest_text
	GR_NC_320_200_graphics
	GR_NC_default_graphics
	GR_NC_width_height_graphics
	GR_NC_biggest_noninterlaced_graphics
	GR_NC_biggest_graphics
	GR_NC_width_height_color_graphics
	GR_NC_width_height_color_text
	GR_NC_custom_graphics
	GR_width_height_bpp_graphics
	GR_width_height_bpp_text
	GR_custom_bpp_graphics
	GR_NC_width_height_bpp_graphics
	GR_NC_width_height_bpp_text
	GR_NC_custom_bpp_graphics
end enum

type GrGraphicsMode as _GR_graphicsModes

enum _GR_frameModes
	GR_frameUndef
	GR_frameText
	GR_frameHERC1
	GR_frameEGAVGA1
	GR_frameEGA4
	GR_frameSVGA4
	GR_frameSVGA8
	GR_frameVGA8X
	GR_frameSVGA16
	GR_frameSVGA24
	GR_frameSVGA32L
	GR_frameSVGA32H
	GR_frameXWIN1 = GR_frameEGAVGA1
	GR_frameXWIN4 = GR_frameSVGA4
	GR_frameXWIN8 = GR_frameSVGA8
	GR_frameXWIN16 = GR_frameSVGA16
	GR_frameXWIN24 = GR_frameSVGA24
	GR_frameXWIN32L = GR_frameSVGA32L
	GR_frameXWIN32H = GR_frameSVGA32H
	GR_frameWIN32_1 = GR_frameEGAVGA1
	GR_frameWIN32_4 = GR_frameSVGA4
	GR_frameWIN32_8 = GR_frameSVGA8
	GR_frameWIN32_16 = GR_frameSVGA16
	GR_frameWIN32_24 = GR_frameSVGA24
	GR_frameWIN32_32L = GR_frameSVGA32L
	GR_frameWIN32_32H = GR_frameSVGA32H
	GR_frameSVGA8_LFB
	GR_frameSVGA16_LFB
	GR_frameSVGA24_LFB
	GR_frameSVGA32L_LFB
	GR_frameSVGA32H_LFB
	GR_frameRAM1
	GR_frameRAM4
	GR_frameRAM8
	GR_frameRAM16
	GR_frameRAM24
	GR_frameRAM32L
	GR_frameRAM32H
	GR_frameRAM3x8
	GR_firstTextFrameMode = GR_frameText
	GR_lastTextFrameMode = GR_frameText
	GR_firstGraphicsFrameMode = GR_frameHERC1
	GR_lastGraphicsFrameMode = GR_frameSVGA32H_LFB
	GR_firstRAMframeMode = GR_frameRAM1
	GR_lastRAMframeMode = GR_frameRAM3x8
end enum

type GrFrameMode as _GR_frameModes

enum _GR_videoAdapters
	GR_UNKNOWN = (-1)
	GR_VGA
	GR_EGA
	GR_HERC
	GR_8514A
	GR_S3
	GR_XWIN
	GR_WIN32
	GR_LNXFB
	GR_MEM
end enum

type GrVideoAdapter as _GR_videoAdapters

type _GR_videoDriver
	name as byte ptr
	adapter as _GR_videoAdapters
	inherit as _GR_videoDriver ptr
	modes as GrVideoMode ptr
	nmodes as integer
	detect as function cdecl() as integer
	init as function cdecl(byval as zstring ptr) as integer
	reset as sub cdecl()
	selectmode as function cdecl(byval as GrVideoDriver ptr, byval as integer, byval as integer, byval as integer, byval as integer, byval as uinteger ptr) as GrVideoMode ptr
	drvflags as uinteger
end type

#define GR_DRIVERF_USER_RESOLUTION 1

type _GR_videoMode
	present as byte
	bpp as byte
	width as short
	height as short
	mode as short
	lineoffset as integer
	privdata as integer
	extinfo as GrVideoModeExt ptr
end type

type _GR_videoModeExt
	mode as _GR_frameModes
	drv as GrFrameDriver ptr
	frame as byte ptr
	cprec as zstring * 3
	cpos as zstring * 3
	flags as integer
	setup as function cdecl(byval as GrVideoMode ptr, byval as integer) as integer
	setvsize as function cdecl(byval as GrVideoMode ptr, byval as integer, byval as integer, byval as GrVideoMode ptr) as integer
	scroll as function cdecl(byval as GrVideoMode ptr, byval as integer, byval as integer, byval as integer ptr) as integer
	setbank as sub cdecl(byval as integer)
	setrwbanks as sub cdecl(byval as integer, byval as integer)
	loadcolor as sub cdecl(byval as integer, byval as integer, byval as integer, byval as integer)
	LFB_Selector as integer
end type

type _GR_frameDriver
	mode as _GR_frameModes
	rmode as _GR_frameModes
	is_video as integer
	row_align as integer
	num_planes as integer
	bits_per_pixel as integer
	max_plane_size as integer
	init as function cdecl(byval as GrVideoMode ptr) as integer
	readpixel as function cdecl(byval as GrFrame ptr, byval as integer, byval as integer) as GrColor
	drawpixel as sub cdecl(byval as integer, byval as integer, byval as GrColor)
	drawline as sub cdecl(byval as integer, byval as integer, byval as integer, byval as integer, byval as GrColor)
	drawhline as sub cdecl(byval as integer, byval as integer, byval as integer, byval as GrColor)
	drawvline as sub cdecl(byval as integer, byval as integer, byval as integer, byval as GrColor)
	drawblock as sub cdecl(byval as integer, byval as integer, byval as integer, byval as integer, byval as GrColor)
	drawbitmap as sub cdecl(byval as integer, byval as integer, byval as integer, byval as integer, byval as zstring ptr, byval as integer, byval as integer, byval as GrColor, byval as GrColor)
	drawpattern as sub cdecl(byval as integer, byval as integer, byval as integer, byval as byte, byval as GrColor, byval as GrColor)
	bitblt as sub cdecl(byval as GrFrame ptr, byval as integer, byval as integer, byval as GrFrame ptr, byval as integer, byval as integer, byval as integer, byval as integer, byval as GrColor)
	bltv2r as sub cdecl(byval as GrFrame ptr, byval as integer, byval as integer, byval as GrFrame ptr, byval as integer, byval as integer, byval as integer, byval as integer, byval as GrColor)
	bltr2v as sub cdecl(byval as GrFrame ptr, byval as integer, byval as integer, byval as GrFrame ptr, byval as integer, byval as integer, byval as integer, byval as integer, byval as GrColor)
	getindexedscanline as function cdecl(byval as GrFrame ptr, byval as integer, byval as integer, byval as integer, byval as integer ptr) as GrColor
	putscanline as sub cdecl(byval as integer, byval as integer, byval as integer, byval as GrColor ptr, byval as GrColor)
end type

type _GR_driverInfo
	vdriver as _GR_videoDriver ptr
	curmode as _GR_videoMode ptr
	actmode as _GR_videoMode
	fdriver as _GR_frameDriver
	sdriver as _GR_frameDriver
	tdriver as _GR_frameDriver
	mcode as _GR_graphicsModes
	deftw as integer
	defth as integer
	defgw as integer
	defgh as integer
	deftc as GrColor
	defgc as GrColor
	vposx as integer
	vposy as integer
	errsfatal as integer
	moderestore as integer
	splitbanks as integer
	curbank as integer
	mdsethook as sub cdecl()
	setbank as sub cdecl(byval as integer)
	setrwbanks as sub cdecl(byval as integer, byval as integer)
end type

extern GrDriverInfo alias "GrDriverInfo" as _GR_driverInfo ptr

declare function GrSetDriver cdecl alias "GrSetDriver" (byval drvspec as zstring ptr) as integer
declare function GrSetMode cdecl alias "GrSetMode" (byval which as GrGraphicsMode, ...) as integer
declare function GrSetViewport cdecl alias "GrSetViewport" (byval xpos as integer, byval ypos as integer) as integer
declare sub GrSetModeHook cdecl alias "GrSetModeHook" (byval hookfunc as sub cdecl())
declare sub GrSetModeRestore cdecl alias "GrSetModeRestore" (byval restoreFlag as integer)
declare sub GrSetErrorHandling cdecl alias "GrSetErrorHandling" (byval exitIfError as integer)
declare sub GrSetEGAVGAmonoDrawnPlane cdecl alias "GrSetEGAVGAmonoDrawnPlane" (byval plane as integer)
declare sub GrSetEGAVGAmonoShownPlane cdecl alias "GrSetEGAVGAmonoShownPlane" (byval plane as integer)
declare function GrGetLibraryVersion cdecl alias "GrGetLibraryVersion" () as uinteger
declare function GrGetLibrarySystem cdecl alias "GrGetLibrarySystem" () as uinteger
declare function GrCurrentMode cdecl alias "GrCurrentMode" () as GrGraphicsMode
declare function GrAdapterType cdecl alias "GrAdapterType" () as GrVideoAdapter
declare function GrCurrentFrameMode cdecl alias "GrCurrentFrameMode" () as GrFrameMode
declare function GrScreenFrameMode cdecl alias "GrScreenFrameMode" () as GrFrameMode
declare function GrCoreFrameMode cdecl alias "GrCoreFrameMode" () as GrFrameMode
declare function GrCurrentVideoDriver cdecl alias "GrCurrentVideoDriver" () as GrVideoDriver ptr
declare function GrCurrentVideoMode cdecl alias "GrCurrentVideoMode" () as GrVideoMode ptr
declare function GrVirtualVideoMode cdecl alias "GrVirtualVideoMode" () as GrVideoMode ptr
declare function GrCurrentFrameDriver cdecl alias "GrCurrentFrameDriver" () as GrFrameDriver ptr
declare function GrScreenFrameDriver cdecl alias "GrScreenFrameDriver" () as GrFrameDriver ptr
declare function GrFirstVideoMode cdecl alias "GrFirstVideoMode" (byval fmode as GrFrameMode) as GrVideoMode ptr
declare function GrNextVideoMode cdecl alias "GrNextVideoMode" (byval prev as GrVideoMode ptr) as GrVideoMode ptr
declare function GrScreenX cdecl alias "GrScreenX" () as integer
declare function GrScreenY cdecl alias "GrScreenY" () as integer
declare function GrVirtualX cdecl alias "GrVirtualX" () as integer
declare function GrVirtualY cdecl alias "GrVirtualY" () as integer
declare function GrViewportX cdecl alias "GrViewportX" () as integer
declare function GrViewportY cdecl alias "GrViewportY" () as integer
declare function GrScreenIsVirtual cdecl alias "GrScreenIsVirtual" () as integer
declare function GrFrameNumPlanes cdecl alias "GrFrameNumPlanes" (byval md as GrFrameMode) as integer
declare function GrFrameLineOffset cdecl alias "GrFrameLineOffset" (byval md as GrFrameMode, byval width as integer) as integer
declare function GrFramePlaneSize cdecl alias "GrFramePlaneSize" (byval md as GrFrameMode, byval w as integer, byval h as integer) as integer
declare function GrFrameContextSize cdecl alias "GrFrameContextSize" (byval md as GrFrameMode, byval w as integer, byval h as integer) as integer
declare function GrNumPlanes cdecl alias "GrNumPlanes" () as integer
declare function GrLineOffset cdecl alias "GrLineOffset" (byval width as integer) as integer
declare function GrPlaneSize cdecl alias "GrPlaneSize" (byval w as integer, byval h as integer) as integer
declare function GrContextSize cdecl alias "GrContextSize" (byval w as integer, byval h as integer) as integer

type _GR_frame
	gf_baseaddr as zstring * 4
	gf_selector as short
	gf_onscreen as byte
	gf_memflags as byte
	gf_lineoffset as integer
	gf_driver as _GR_frameDriver ptr
end type

type _GR_context
	gc_frame as _GR_frame
	gc_root as _GR_context ptr
	gc_xmax as integer
	gc_ymax as integer
	gc_xoffset as integer
	gc_yoffset as integer
	gc_xcliplo as integer
	gc_ycliplo as integer
	gc_xcliphi as integer
	gc_ycliphi as integer
	gc_usrxbase as integer
	gc_usrybase as integer
	gc_usrwidth as integer
	gc_usrheight as integer
end type

type _GR_contextInfo
	current as _GR_context
	screen as _GR_context
end type

extern GrContextInfo alias "GrContextInfo" as _GR_contextInfo ptr

declare function GrCreateContext cdecl alias "GrCreateContext" (byval w as integer, byval h as integer, byval memory as byte ptr ptr, byval where as GrContext ptr) as GrContext ptr
declare function GrCreateFrameContext cdecl alias "GrCreateFrameContext" (byval md as GrFrameMode, byval w as integer, byval h as integer, byval memory as byte ptr ptr, byval where as GrContext ptr) as GrContext ptr
declare function GrCreateSubContext cdecl alias "GrCreateSubContext" (byval x1 as integer, byval y1 as integer, byval x2 as integer, byval y2 as integer, byval parent as GrContext ptr, byval where as GrContext ptr) as GrContext ptr
declare function GrSaveContext cdecl alias "GrSaveContext" (byval where as GrContext ptr) as GrContext ptr
declare function GrCurrentContext cdecl alias "GrCurrentContext" () as GrContext ptr
declare function GrScreenContext cdecl alias "GrScreenContext" () as GrContext ptr
declare sub GrDestroyContext cdecl alias "GrDestroyContext" (byval context as GrContext ptr)
declare sub GrResizeSubContext cdecl alias "GrResizeSubContext" (byval context as GrContext ptr, byval x1 as integer, byval y1 as integer, byval x2 as integer, byval y2 as integer)
declare sub GrSetContext cdecl alias "GrSetContext" (byval context as GrContext ptr)
declare sub GrSetClipBox cdecl alias "GrSetClipBox" (byval x1 as integer, byval y1 as integer, byval x2 as integer, byval y2 as integer)
declare sub GrSetClipBoxC cdecl alias "GrSetClipBoxC" (byval c as GrContext ptr, byval x1 as integer, byval y1 as integer, byval x2 as integer, byval y2 as integer)
declare sub GrGetClipBox cdecl alias "GrGetClipBox" (byval x1p as integer ptr, byval y1p as integer ptr, byval x2p as integer ptr, byval y2p as integer ptr)
declare sub GrGetClipBoxC cdecl alias "GrGetClipBoxC" (byval c as GrContext ptr, byval x1p as integer ptr, byval y1p as integer ptr, byval x2p as integer ptr, byval y2p as integer ptr)
declare sub GrResetClipBox cdecl alias "GrResetClipBox" ()
declare sub GrResetClipBoxC cdecl alias "GrResetClipBoxC" (byval c as GrContext ptr)
declare function GrMaxX cdecl alias "GrMaxX" () as integer
declare function GrMaxY cdecl alias "GrMaxY" () as integer
declare function GrSizeX cdecl alias "GrSizeX" () as integer
declare function GrSizeY cdecl alias "GrSizeY" () as integer
declare function GrLowX cdecl alias "GrLowX" () as integer
declare function GrLowY cdecl alias "GrLowY" () as integer
declare function GrHighX cdecl alias "GrHighX" () as integer
declare function GrHighY cdecl alias "GrHighY" () as integer

#define GrWRITE 0UL
#define GrXOR &h01000000UL
#define GrOR &h02000000UL
#define GrAND &h03000000UL
#define GrIMAGE &h04000000UL
#define GrCVALUEMASK &h00ffffffUL
#define GrCMODEMASK &hff000000UL
#define GrNOCOLOR (&h01000000UL or 0)

declare function GrColorValue cdecl alias "GrColorValue" (byval c as GrColor) as GrColor
declare function GrColorMode cdecl alias "GrColorMode" (byval c as GrColor) as GrColor
declare function GrWriteModeColor cdecl alias "GrWriteModeColor" (byval c as GrColor) as GrColor
declare function GrXorModeColor cdecl alias "GrXorModeColor" (byval c as GrColor) as GrColor
declare function GrOrModeColor cdecl alias "GrOrModeColor" (byval c as GrColor) as GrColor
declare function GrAndModeColor cdecl alias "GrAndModeColor" (byval c as GrColor) as GrColor
declare function GrImageModeColor cdecl alias "GrImageModeColor" (byval c as GrColor) as GrColor

type _GR_colorInfo_ctable
	r as ubyte
	g as ubyte
	b as ubyte
	defined:1 as uinteger
	writable:1 as uinteger
	nused as uinteger
end type

type _GR_colorInfo
	ncolors as GrColor
	nfree as GrColor
	black as GrColor
	white as GrColor
	RGBmode as uinteger
	prec(0 to 3-1) as uinteger
	pos(0 to 3-1) as uinteger
	mask(0 to 3-1) as uinteger
	round(0 to 3-1) as uinteger
	shift(0 to 3-1) as uinteger
	norm as uinteger
	ctable(0 to 256-1) as _GR_colorInfo_ctable
end type

extern GrColorInfo alias "GrColorInfo" as _GR_colorInfo ptr

declare sub GrResetColors cdecl alias "GrResetColors" ()
declare sub GrSetRGBcolorMode cdecl alias "GrSetRGBcolorMode" ()
declare sub GrRefreshColors cdecl alias "GrRefreshColors" ()
declare function GrNumColors cdecl alias "GrNumColors" () as GrColor
declare function GrNumFreeColors cdecl alias "GrNumFreeColors" () as GrColor
declare function GrBlack cdecl alias "GrBlack" () as GrColor
declare function GrWhite cdecl alias "GrWhite" () as GrColor
declare function GrBuildRGBcolorT cdecl alias "GrBuildRGBcolorT" (byval r as integer, byval g as integer, byval b as integer) as GrColor
declare function GrBuildRGBcolorR cdecl alias "GrBuildRGBcolorR" (byval r as integer, byval g as integer, byval b as integer) as GrColor
declare function GrRGBcolorRed cdecl alias "GrRGBcolorRed" (byval c as GrColor) as integer
declare function GrRGBcolorGreen cdecl alias "GrRGBcolorGreen" (byval c as GrColor) as integer
declare function GrRGBcolorBlue cdecl alias "GrRGBcolorBlue" (byval c as GrColor) as integer
declare function GrAllocColor cdecl alias "GrAllocColor" (byval r as integer, byval g as integer, byval b as integer) as GrColor
declare function GrAllocColorID cdecl alias "GrAllocColorID" (byval r as integer, byval g as integer, byval b as integer) as GrColor
declare function GrAllocColor2 cdecl alias "GrAllocColor2" (byval hcolor as integer) as GrColor
declare function GrAllocColor2ID cdecl alias "GrAllocColor2ID" (byval hcolor as integer) as GrColor
declare function GrAllocCell cdecl alias "GrAllocCell" () as GrColor
declare function GrAllocEgaColors cdecl alias "GrAllocEgaColors" () as GrColor ptr
declare sub GrSetColor cdecl alias "GrSetColor" (byval c as GrColor, byval r as integer, byval g as integer, byval b as integer)
declare sub GrFreeColor cdecl alias "GrFreeColor" (byval c as GrColor)
declare sub GrFreeCell cdecl alias "GrFreeCell" (byval c as GrColor)
declare sub GrQueryColor cdecl alias "GrQueryColor" (byval c as GrColor, byval r as integer ptr, byval g as integer ptr, byval b as integer ptr)
declare sub GrQueryColorID cdecl alias "GrQueryColorID" (byval c as GrColor, byval r as integer ptr, byval g as integer ptr, byval b as integer ptr)
declare sub GrQueryColor2 cdecl alias "GrQueryColor2" (byval c as GrColor, byval hcolor as integer ptr)
declare sub GrQueryColor2ID cdecl alias "GrQueryColor2ID" (byval c as GrColor, byval hcolor as integer ptr)
declare function GrColorSaveBufferSize cdecl alias "GrColorSaveBufferSize" () as integer
declare sub GrSaveColors cdecl alias "GrSaveColors" (byval buffer as any ptr)
declare sub GrRestoreColors cdecl alias "GrRestoreColors" (byval buffer as any ptr)

type GrColorTableP as GrColor ptr

#define GR_MAX_POLYGON_POINTS (1000000)
#define GR_MAX_ELLIPSE_POINTS (1024+5)
#define GR_MAX_ANGLE_VALUE (3600)
#define GR_ARC_STYLE_OPEN 0
#define GR_ARC_STYLE_CLOSE1 1
#define GR_ARC_STYLE_CLOSE2 2

type GrFBoxColors
	fbx_intcolor as GrColor
	fbx_topcolor as GrColor
	fbx_rightcolor as GrColor
	fbx_bottomcolor as GrColor
	fbx_leftcolor as GrColor
end type

declare sub GrClearScreen cdecl alias "GrClearScreen" (byval bg as GrColor)
declare sub GrClearContext cdecl alias "GrClearContext" (byval bg as GrColor)
declare sub GrClearClipBox cdecl alias "GrClearClipBox" (byval bg as GrColor)
declare sub GrPlot cdecl alias "GrPlot" (byval x as integer, byval y as integer, byval c as GrColor)
declare sub GrLine cdecl alias "GrLine" (byval x1 as integer, byval y1 as integer, byval x2 as integer, byval y2 as integer, byval c as GrColor)
declare sub GrHLine cdecl alias "GrHLine" (byval x1 as integer, byval x2 as integer, byval y as integer, byval c as GrColor)
declare sub GrVLine cdecl alias "GrVLine" (byval x as integer, byval y1 as integer, byval y2 as integer, byval c as GrColor)
declare sub GrBox cdecl alias "GrBox" (byval x1 as integer, byval y1 as integer, byval x2 as integer, byval y2 as integer, byval c as GrColor)
declare sub GrFilledBox cdecl alias "GrFilledBox" (byval x1 as integer, byval y1 as integer, byval x2 as integer, byval y2 as integer, byval c as GrColor)
declare sub GrFramedBox cdecl alias "GrFramedBox" (byval x1 as integer, byval y1 as integer, byval x2 as integer, byval y2 as integer, byval wdt as integer, byval c as GrFBoxColors ptr)
declare function GrGenerateEllipse cdecl alias "GrGenerateEllipse" (byval xc as integer, byval yc as integer, byval xa as integer, byval ya as integer, byval points as integer ptr ptr ptr) as integer
declare function GrGenerateEllipseArc cdecl alias "GrGenerateEllipseArc" (byval xc as integer, byval yc as integer, byval xa as integer, byval ya as integer, byval start as integer, byval end as integer, byval points as integer ptr ptr ptr) as integer
declare sub GrLastArcCoords cdecl alias "GrLastArcCoords" (byval xs as integer ptr, byval ys as integer ptr, byval xe as integer ptr, byval ye as integer ptr, byval xc as integer ptr, byval yc as integer ptr)
declare sub GrCircle cdecl alias "GrCircle" (byval xc as integer, byval yc as integer, byval r as integer, byval c as GrColor)
declare sub GrEllipse cdecl alias "GrEllipse" (byval xc as integer, byval yc as integer, byval xa as integer, byval ya as integer, byval c as GrColor)
declare sub GrCircleArc cdecl alias "GrCircleArc" (byval xc as integer, byval yc as integer, byval r as integer, byval start as integer, byval end as integer, byval style as integer, byval c as GrColor)
declare sub GrEllipseArc cdecl alias "GrEllipseArc" (byval xc as integer, byval yc as integer, byval xa as integer, byval ya as integer, byval start as integer, byval end as integer, byval style as integer, byval c as GrColor)
declare sub GrFilledCircle cdecl alias "GrFilledCircle" (byval xc as integer, byval yc as integer, byval r as integer, byval c as GrColor)
declare sub GrFilledEllipse cdecl alias "GrFilledEllipse" (byval xc as integer, byval yc as integer, byval xa as integer, byval ya as integer, byval c as GrColor)
declare sub GrFilledCircleArc cdecl alias "GrFilledCircleArc" (byval xc as integer, byval yc as integer, byval r as integer, byval start as integer, byval end as integer, byval style as integer, byval c as GrColor)
declare sub GrFilledEllipseArc cdecl alias "GrFilledEllipseArc" (byval xc as integer, byval yc as integer, byval xa as integer, byval ya as integer, byval start as integer, byval end as integer, byval style as integer, byval c as GrColor)
declare sub GrPolyLine cdecl alias "GrPolyLine" (byval numpts as integer, byval points as integer ptr ptr ptr, byval c as GrColor)
declare sub GrPolygon cdecl alias "GrPolygon" (byval numpts as integer, byval points as integer ptr ptr ptr, byval c as GrColor)
declare sub GrFilledConvexPolygon cdecl alias "GrFilledConvexPolygon" (byval numpts as integer, byval points as integer ptr ptr ptr, byval c as GrColor)
declare sub GrFilledPolygon cdecl alias "GrFilledPolygon" (byval numpts as integer, byval points as integer ptr ptr ptr, byval c as GrColor)
declare sub GrBitBlt cdecl alias "GrBitBlt" (byval dst as GrContext ptr, byval x as integer, byval y as integer, byval src as GrContext ptr, byval x1 as integer, byval y1 as integer, byval x2 as integer, byval y2 as integer, byval op as GrColor)
declare sub GrBitBlt1bpp cdecl alias "GrBitBlt1bpp" (byval dst as GrContext ptr, byval dx as integer, byval dy as integer, byval src as GrContext ptr, byval x1 as integer, byval y1 as integer, byval x2 as integer, byval y2 as integer, byval fg as GrColor, byval bg as GrColor)
declare sub GrFloodFill cdecl alias "GrFloodFill" (byval x as integer, byval y as integer, byval border as GrColor, byval c as GrColor)
declare function GrPixel cdecl alias "GrPixel" (byval x as integer, byval y as integer) as GrColor
declare function GrPixelC cdecl alias "GrPixelC" (byval c as GrContext ptr, byval x as integer, byval y as integer) as GrColor
declare function GrGetScanline cdecl alias "GrGetScanline" (byval x1 as integer, byval x2 as integer, byval yy as integer) as GrColor ptr
declare function GrGetScanlineC cdecl alias "GrGetScanlineC" (byval ctx as GrContext ptr, byval x1 as integer, byval x2 as integer, byval yy as integer) as GrColor ptr
declare sub GrPutScanline cdecl alias "GrPutScanline" (byval x1 as integer, byval x2 as integer, byval yy as integer, byval c as GrColor ptr, byval op as GrColor)
declare sub GrPlotNC cdecl alias "GrPlotNC" (byval x as integer, byval y as integer, byval c as GrColor)
declare sub GrLineNC cdecl alias "GrLineNC" (byval x1 as integer, byval y1 as integer, byval x2 as integer, byval y2 as integer, byval c as GrColor)
declare sub GrHLineNC cdecl alias "GrHLineNC" (byval x1 as integer, byval x2 as integer, byval y as integer, byval c as GrColor)
declare sub GrVLineNC cdecl alias "GrVLineNC" (byval x as integer, byval y1 as integer, byval y2 as integer, byval c as GrColor)
declare sub GrBoxNC cdecl alias "GrBoxNC" (byval x1 as integer, byval y1 as integer, byval x2 as integer, byval y2 as integer, byval c as GrColor)
declare sub GrFilledBoxNC cdecl alias "GrFilledBoxNC" (byval x1 as integer, byval y1 as integer, byval x2 as integer, byval y2 as integer, byval c as GrColor)
declare sub GrFramedBoxNC cdecl alias "GrFramedBoxNC" (byval x1 as integer, byval y1 as integer, byval x2 as integer, byval y2 as integer, byval wdt as integer, byval c as GrFBoxColors ptr)
declare sub GrBitBltNC cdecl alias "GrBitBltNC" (byval dst as GrContext ptr, byval x as integer, byval y as integer, byval src as GrContext ptr, byval x1 as integer, byval y1 as integer, byval x2 as integer, byval y2 as integer, byval op as GrColor)
declare function GrPixelNC cdecl alias "GrPixelNC" (byval x as integer, byval y as integer) as GrColor
declare function GrPixelCNC cdecl alias "GrPixelCNC" (byval c as GrContext ptr, byval x as integer, byval y as integer) as GrColor

#define GR_TEXT_RIGHT 0
#define GR_TEXT_DOWN 1
#define GR_TEXT_LEFT 2
#define GR_TEXT_UP 3
#define GR_TEXT_DEFAULT 0
#define GR_ALIGN_LEFT 0
#define GR_ALIGN_TOP 0
#define GR_ALIGN_CENTER 1
#define GR_ALIGN_RIGHT 2
#define GR_ALIGN_BOTTOM 2
#define GR_ALIGN_BASELINE 3
#define GR_ALIGN_DEFAULT 0
#define GR_BYTE_TEXT 0
#define GR_WORD_TEXT 1
#define GR_ATTR_TEXT 2
#define GR_UNDERLINE_TEXT (&h01000000UL shl 4)
#define GR_FONTCVT_NONE 0
#define GR_FONTCVT_SKIPCHARS 1
#define GR_FONTCVT_RESIZE 2
#define GR_FONTCVT_ITALICIZE 4
#define GR_FONTCVT_BOLDIFY 8
#define GR_FONTCVT_FIXIFY 16
#define GR_FONTCVT_PROPORTION 32

#define GR_BUILD_ATTR(fg,bg,ul) iif( _GR_textattrintensevideo, _
                                ((fg) and 15) or (((bg) and 15) shl 4), _
                                ((fg) and 15) or (((bg) and 7) shl 4) or (iif(ul, 128, 0)) )
#define GR_ATTR_FGCOLOR(attr)   ((attr) and 15)
#define GR_ATTR_BGCOLOR(attr)   iif( _GR_textattrintensevideo, ((attr) shr 4) and 15, ((attr) shr 4) and 7 )
#define GR_ATTR_UNDERLINE(attr) iif( _GR_textattrintensevideo, 0, (attr) and 128 )


extern _GR_textattrintensevideo alias "_GR_textattrintensevideo" as integer

type _GR_fontHeader
	name as byte ptr
	family as byte ptr
	proportional as byte
	scalable as byte
	preloaded as byte
	modified as byte
	width as uinteger
	height as uinteger
	baseline as uinteger
	ulpos as uinteger
	ulheight as uinteger
	minchar as uinteger
	numchars as uinteger
end type

type GrFontHeader as _GR_fontHeader

type _GR_fontChrInfo
	width as uinteger
	offset as uinteger
end type

type GrFontChrInfo as _GR_fontChrInfo

type _GR_font
	h as _GR_fontHeader
	bitmap as byte ptr
	auxmap as byte ptr
	minwidth as uinteger
	maxwidth as uinteger
	auxsize as uinteger
	auxnext as uinteger
	auxoffs(0 to 7-1) as uinteger ptr
	chrinfo(0 to 1-1) as _GR_fontChrInfo
end type

type GrFont as _GR_font

extern GrFont_PC6x8 alias "GrFont_PC6x8" as GrFont
extern GrFont_PC8x8 alias "GrFont_PC8x8" as GrFont
extern GrFont_PC8x14 alias "GrFont_PC8x14" as GrFont
extern GrFont_PC8x16 alias "GrFont_PC8x16" as GrFont


declare function GrLoadFont cdecl alias "GrLoadFont" (byval name as zstring ptr) as GrFont ptr
declare function GrLoadConvertedFont cdecl alias "GrLoadConvertedFont" (byval name as zstring ptr, byval cvt as integer, byval w as integer, byval h as integer, byval minch as integer, byval maxch as integer) as GrFont ptr
declare function GrBuildConvertedFont cdecl alias "GrBuildConvertedFont" (byval from as GrFont ptr, byval cvt as integer, byval w as integer, byval h as integer, byval minch as integer, byval maxch as integer) as GrFont ptr
declare sub GrUnloadFont cdecl alias "GrUnloadFont" (byval font as GrFont ptr)
declare sub GrDumpFont cdecl alias "GrDumpFont" (byval f as GrFont ptr, byval CsymbolName as zstring ptr, byval fileName as zstring ptr)
declare sub GrDumpFnaFont cdecl alias "GrDumpFnaFont" (byval f as GrFont ptr, byval fileName as zstring ptr)
declare sub GrSetFontPath cdecl alias "GrSetFontPath" (byval path_list as zstring ptr)
declare function GrFontCharPresent cdecl alias "GrFontCharPresent" (byval font as GrFont ptr, byval chr as integer) as integer
declare function GrFontCharWidth cdecl alias "GrFontCharWidth" (byval font as GrFont ptr, byval chr as integer) as integer
declare function GrFontCharHeight cdecl alias "GrFontCharHeight" (byval font as GrFont ptr, byval chr as integer) as integer
declare function GrFontCharBmpRowSize cdecl alias "GrFontCharBmpRowSize" (byval font as GrFont ptr, byval chr as integer) as integer
declare function GrFontCharBitmapSize cdecl alias "GrFontCharBitmapSize" (byval font as GrFont ptr, byval chr as integer) as integer
declare function GrFontStringWidth cdecl alias "GrFontStringWidth" (byval font as GrFont ptr, byval text as any ptr, byval len as integer, byval type as integer) as integer
declare function GrFontStringHeight cdecl alias "GrFontStringHeight" (byval font as GrFont ptr, byval text as any ptr, byval len as integer, byval type as integer) as integer
declare function GrProportionalTextWidth cdecl alias "GrProportionalTextWidth" (byval font as GrFont ptr, byval text as any ptr, byval len as integer, byval type as integer) as integer
declare function GrBuildAuxiliaryBitmap cdecl alias "GrBuildAuxiliaryBitmap" (byval font as GrFont ptr, byval chr as integer, byval dir as integer, byval ul as integer) as zstring ptr
declare function GrFontCharBitmap cdecl alias "GrFontCharBitmap" (byval font as GrFont ptr, byval chr as integer) as zstring ptr
declare function GrFontCharAuxBmp cdecl alias "GrFontCharAuxBmp" (byval font as GrFont ptr, byval chr as integer, byval dir as integer, byval ul as integer) as zstring ptr

union _GR_textColor
	v as GrColor
	p as GrColorTableP
end union

type GrTextColor as _GR_textColor

type _GR_textOption
	txo_font as _GR_font ptr
	txo_fgcolor as _GR_textColor
	txo_bgcolor as _GR_textColor
	txo_chrtype as byte
	txo_direct as byte
	txo_xalign as byte
	txo_yalign as byte
end type

type GrTextOption as _GR_textOption

type GrTextRegion
	txr_font as _GR_font ptr
	txr_fgcolor as _GR_textColor
	txr_bgcolor as _GR_textColor
	txr_buffer as any ptr
	txr_backup as any ptr
	txr_width as integer
	txr_height as integer
	txr_lineoffset as integer
	txr_xpos as integer
	txr_ypos as integer
	txr_chrtype as byte
end type

declare function GrCharWidth cdecl alias "GrCharWidth" (byval chr as integer, byval opt as GrTextOption ptr) as integer
declare function GrCharHeight cdecl alias "GrCharHeight" (byval chr as integer, byval opt as GrTextOption ptr) as integer
declare sub GrCharSize cdecl alias "GrCharSize" (byval chr as integer, byval opt as GrTextOption ptr, byval w as integer ptr, byval h as integer ptr)
declare function GrStringWidth cdecl alias "GrStringWidth" (byval text as any ptr, byval length as integer, byval opt as GrTextOption ptr) as integer
declare function GrStringHeight cdecl alias "GrStringHeight" (byval text as any ptr, byval length as integer, byval opt as GrTextOption ptr) as integer
declare sub GrStringSize cdecl alias "GrStringSize" (byval text as any ptr, byval length as integer, byval opt as GrTextOption ptr, byval w as integer ptr, byval h as integer ptr)
declare sub GrDrawChar cdecl alias "GrDrawChar" (byval chr as integer, byval x as integer, byval y as integer, byval opt as GrTextOption ptr)
declare sub GrDrawString cdecl alias "GrDrawString" (byval text as any ptr, byval length as integer, byval x as integer, byval y as integer, byval opt as GrTextOption ptr)
declare sub GrTextXY cdecl alias "GrTextXY" (byval x as integer, byval y as integer, byval text as zstring ptr, byval fg as GrColor, byval bg as GrColor)
declare sub GrDumpChar cdecl alias "GrDumpChar" (byval chr as integer, byval col as integer, byval row as integer, byval r as GrTextRegion ptr)
declare sub GrDumpText cdecl alias "GrDumpText" (byval col as integer, byval row as integer, byval wdt as integer, byval hgt as integer, byval r as GrTextRegion ptr)
declare sub GrDumpTextRegion cdecl alias "GrDumpTextRegion" (byval r as GrTextRegion ptr)

type GrLineOption
	lno_color as GrColor
	lno_width as integer
	lno_pattlen as integer
	lno_dashpat as ubyte ptr
end type

declare sub GrCustomLine cdecl alias "GrCustomLine" (byval x1 as integer, byval y1 as integer, byval x2 as integer, byval y2 as integer, byval o as GrLineOption ptr)
declare sub GrCustomBox cdecl alias "GrCustomBox" (byval x1 as integer, byval y1 as integer, byval x2 as integer, byval y2 as integer, byval o as GrLineOption ptr)
declare sub GrCustomCircle cdecl alias "GrCustomCircle" (byval xc as integer, byval yc as integer, byval r as integer, byval o as GrLineOption ptr)
declare sub GrCustomEllipse cdecl alias "GrCustomEllipse" (byval xc as integer, byval yc as integer, byval xa as integer, byval ya as integer, byval o as GrLineOption ptr)
declare sub GrCustomCircleArc cdecl alias "GrCustomCircleArc" (byval xc as integer, byval yc as integer, byval r as integer, byval start as integer, byval end as integer, byval style as integer, byval o as GrLineOption ptr)
declare sub GrCustomEllipseArc cdecl alias "GrCustomEllipseArc" (byval xc as integer, byval yc as integer, byval xa as integer, byval ya as integer, byval start as integer, byval end as integer, byval style as integer, byval o as GrLineOption ptr)
declare sub GrCustomPolyLine cdecl alias "GrCustomPolyLine" (byval numpts as integer, byval points as integer ptr ptr ptr, byval o as GrLineOption ptr)
declare sub GrCustomPolygon cdecl alias "GrCustomPolygon" (byval numpts as integer, byval points as integer ptr ptr ptr, byval o as GrLineOption ptr)

type _GR_bitmap
	bmp_ispixmap as integer
	bmp_height as integer
	bmp_data as byte ptr
	bmp_fgcolor as GrColor
	bmp_bgcolor as GrColor
	bmp_memflags as integer
end type

type GrBitmap as _GR_bitmap

type _GR_pixmap
	pxp_ispixmap as integer
	pxp_width as integer
	pxp_height as integer
	pxp_oper as GrColor
	pxp_source as _GR_frame
end type

type GrPixmap as _GR_pixmap

union _GR_pattern
	gp_ispixmap as integer
	gp_bitmap as GrBitmap
	gp_pixmap as GrPixmap
end union

type GrPattern as _GR_pattern

type GrLinePattern
	lnp_pattern as GrPattern ptr
	lnp_option as GrLineOption ptr
end type

declare function GrBuildPixmap cdecl alias "GrBuildPixmap" (byval pixels as zstring ptr, byval w as integer, byval h as integer, byval colors as GrColorTableP) as GrPattern ptr
declare function GrBuildPixmapFromBits cdecl alias "GrBuildPixmapFromBits" (byval bits as zstring ptr, byval w as integer, byval h as integer, byval fgc as GrColor, byval bgc as GrColor) as GrPattern ptr
declare function GrConvertToPixmap cdecl alias "GrConvertToPixmap" (byval src as GrContext ptr) as GrPattern ptr
declare sub GrDestroyPattern cdecl alias "GrDestroyPattern" (byval p as GrPattern ptr)
declare sub GrPatternedLine cdecl alias "GrPatternedLine" (byval x1 as integer, byval y1 as integer, byval x2 as integer, byval y2 as integer, byval lp as GrLinePattern ptr)
declare sub GrPatternedBox cdecl alias "GrPatternedBox" (byval x1 as integer, byval y1 as integer, byval x2 as integer, byval y2 as integer, byval lp as GrLinePattern ptr)
declare sub GrPatternedCircle cdecl alias "GrPatternedCircle" (byval xc as integer, byval yc as integer, byval r as integer, byval lp as GrLinePattern ptr)
declare sub GrPatternedEllipse cdecl alias "GrPatternedEllipse" (byval xc as integer, byval yc as integer, byval xa as integer, byval ya as integer, byval lp as GrLinePattern ptr)
declare sub GrPatternedCircleArc cdecl alias "GrPatternedCircleArc" (byval xc as integer, byval yc as integer, byval r as integer, byval start as integer, byval end as integer, byval style as integer, byval lp as GrLinePattern ptr)
declare sub GrPatternedEllipseArc cdecl alias "GrPatternedEllipseArc" (byval xc as integer, byval yc as integer, byval xa as integer, byval ya as integer, byval start as integer, byval end as integer, byval style as integer, byval lp as GrLinePattern ptr)
declare sub GrPatternedPolyLine cdecl alias "GrPatternedPolyLine" (byval numpts as integer, byval points as integer ptr ptr ptr, byval lp as GrLinePattern ptr)
declare sub GrPatternedPolygon cdecl alias "GrPatternedPolygon" (byval numpts as integer, byval points as integer ptr ptr ptr, byval lp as GrLinePattern ptr)
declare sub GrPatternFilledPlot cdecl alias "GrPatternFilledPlot" (byval x as integer, byval y as integer, byval p as GrPattern ptr)
declare sub GrPatternFilledLine cdecl alias "GrPatternFilledLine" (byval x1 as integer, byval y1 as integer, byval x2 as integer, byval y2 as integer, byval p as GrPattern ptr)
declare sub GrPatternFilledBox cdecl alias "GrPatternFilledBox" (byval x1 as integer, byval y1 as integer, byval x2 as integer, byval y2 as integer, byval p as GrPattern ptr)
declare sub GrPatternFilledCircle cdecl alias "GrPatternFilledCircle" (byval xc as integer, byval yc as integer, byval r as integer, byval p as GrPattern ptr)
declare sub GrPatternFilledEllipse cdecl alias "GrPatternFilledEllipse" (byval xc as integer, byval yc as integer, byval xa as integer, byval ya as integer, byval p as GrPattern ptr)
declare sub GrPatternFilledCircleArc cdecl alias "GrPatternFilledCircleArc" (byval xc as integer, byval yc as integer, byval r as integer, byval start as integer, byval end as integer, byval style as integer, byval p as GrPattern ptr)
declare sub GrPatternFilledEllipseArc cdecl alias "GrPatternFilledEllipseArc" (byval xc as integer, byval yc as integer, byval xa as integer, byval ya as integer, byval start as integer, byval end as integer, byval style as integer, byval p as GrPattern ptr)
declare sub GrPatternFilledConvexPolygon cdecl alias "GrPatternFilledConvexPolygon" (byval numpts as integer, byval points as integer ptr ptr ptr, byval p as GrPattern ptr)
declare sub GrPatternFilledPolygon cdecl alias "GrPatternFilledPolygon" (byval numpts as integer, byval points as integer ptr ptr ptr, byval p as GrPattern ptr)
declare sub GrPatternFloodFill cdecl alias "GrPatternFloodFill" (byval x as integer, byval y as integer, byval border as GrColor, byval p as GrPattern ptr)
declare sub GrPatternDrawChar cdecl alias "GrPatternDrawChar" (byval chr as integer, byval x as integer, byval y as integer, byval opt as GrTextOption ptr, byval p as GrPattern ptr)
declare sub GrPatternDrawString cdecl alias "GrPatternDrawString" (byval text as any ptr, byval length as integer, byval x as integer, byval y as integer, byval opt as GrTextOption ptr, byval p as GrPattern ptr)
declare sub GrPatternDrawStringExt cdecl alias "GrPatternDrawStringExt" (byval text as any ptr, byval length as integer, byval x as integer, byval y as integer, byval opt as GrTextOption ptr, byval p as GrPattern ptr)

#define GR_IMAGE_INVERSE_LR &h01
#define GR_IMAGE_INVERSE_TD &h02

declare function GrImageBuild cdecl alias "GrImageBuild" (byval pixels as zstring ptr, byval w as integer, byval h as integer, byval colors as GrColorTableP) as GrPixmap ptr
declare sub GrImageDestroy cdecl alias "GrImageDestroy" (byval i as GrPixmap ptr)
declare sub GrImageDisplay cdecl alias "GrImageDisplay" (byval x as integer, byval y as integer, byval i as GrPixmap ptr)
declare sub GrImageDisplayExt cdecl alias "GrImageDisplayExt" (byval x1 as integer, byval y1 as integer, byval x2 as integer, byval y2 as integer, byval i as GrPixmap ptr)
declare sub GrImageFilledBoxAlign cdecl alias "GrImageFilledBoxAlign" (byval xo as integer, byval yo as integer, byval x1 as integer, byval y1 as integer, byval x2 as integer, byval y2 as integer, byval p as GrPixmap ptr)
declare sub GrImageHLineAlign cdecl alias "GrImageHLineAlign" (byval xo as integer, byval yo as integer, byval x as integer, byval y as integer, byval width as integer, byval p as GrPixmap ptr)
declare sub GrImagePlotAlign cdecl alias "GrImagePlotAlign" (byval xo as integer, byval yo as integer, byval x as integer, byval y as integer, byval p as GrPixmap ptr)
declare function GrImageInverse cdecl alias "GrImageInverse" (byval p as GrPixmap ptr, byval flag as integer) as GrPixmap ptr
declare function GrImageStretch cdecl alias "GrImageStretch" (byval p as GrPixmap ptr, byval nwidth as integer, byval nheight as integer) as GrPixmap ptr
declare function GrImageFromPattern cdecl alias "GrImageFromPattern" (byval p as GrPattern ptr) as GrPixmap ptr
declare function GrImageFromContext cdecl alias "GrImageFromContext" (byval c as GrContext ptr) as GrPixmap ptr
declare function GrImageBuildUsedAsPattern cdecl alias "GrImageBuildUsedAsPattern" (byval pixels as zstring ptr, byval w as integer, byval h as integer, byval colors as GrColorTableP) as GrPixmap ptr
declare function GrPatternFromImage cdecl alias "GrPatternFromImage" (byval p as GrPixmap ptr) as GrPattern ptr
declare sub GrSetUserWindow cdecl alias "GrSetUserWindow" (byval x1 as integer, byval y1 as integer, byval x2 as integer, byval y2 as integer)
declare sub GrGetUserWindow cdecl alias "GrGetUserWindow" (byval x1 as integer ptr, byval y1 as integer ptr, byval x2 as integer ptr, byval y2 as integer ptr)
declare sub GrGetScreenCoord cdecl alias "GrGetScreenCoord" (byval x as integer ptr, byval y as integer ptr)
declare sub GrGetUserCoord cdecl alias "GrGetUserCoord" (byval x as integer ptr, byval y as integer ptr)
declare sub GrUsrPlot cdecl alias "GrUsrPlot" (byval x as integer, byval y as integer, byval c as GrColor)
declare sub GrUsrLine cdecl alias "GrUsrLine" (byval x1 as integer, byval y1 as integer, byval x2 as integer, byval y2 as integer, byval c as GrColor)
declare sub GrUsrHLine cdecl alias "GrUsrHLine" (byval x1 as integer, byval x2 as integer, byval y as integer, byval c as GrColor)
declare sub GrUsrVLine cdecl alias "GrUsrVLine" (byval x as integer, byval y1 as integer, byval y2 as integer, byval c as GrColor)
declare sub GrUsrBox cdecl alias "GrUsrBox" (byval x1 as integer, byval y1 as integer, byval x2 as integer, byval y2 as integer, byval c as GrColor)
declare sub GrUsrFilledBox cdecl alias "GrUsrFilledBox" (byval x1 as integer, byval y1 as integer, byval x2 as integer, byval y2 as integer, byval c as GrColor)
declare sub GrUsrFramedBox cdecl alias "GrUsrFramedBox" (byval x1 as integer, byval y1 as integer, byval x2 as integer, byval y2 as integer, byval wdt as integer, byval c as GrFBoxColors ptr)
declare sub GrUsrCircle cdecl alias "GrUsrCircle" (byval xc as integer, byval yc as integer, byval r as integer, byval c as GrColor)
declare sub GrUsrEllipse cdecl alias "GrUsrEllipse" (byval xc as integer, byval yc as integer, byval xa as integer, byval ya as integer, byval c as GrColor)
declare sub GrUsrCircleArc cdecl alias "GrUsrCircleArc" (byval xc as integer, byval yc as integer, byval r as integer, byval start as integer, byval end as integer, byval style as integer, byval c as GrColor)
declare sub GrUsrEllipseArc cdecl alias "GrUsrEllipseArc" (byval xc as integer, byval yc as integer, byval xa as integer, byval ya as integer, byval start as integer, byval end as integer, byval style as integer, byval c as GrColor)
declare sub GrUsrFilledCircle cdecl alias "GrUsrFilledCircle" (byval xc as integer, byval yc as integer, byval r as integer, byval c as GrColor)
declare sub GrUsrFilledEllipse cdecl alias "GrUsrFilledEllipse" (byval xc as integer, byval yc as integer, byval xa as integer, byval ya as integer, byval c as GrColor)
declare sub GrUsrFilledCircleArc cdecl alias "GrUsrFilledCircleArc" (byval xc as integer, byval yc as integer, byval r as integer, byval start as integer, byval end as integer, byval style as integer, byval c as GrColor)
declare sub GrUsrFilledEllipseArc cdecl alias "GrUsrFilledEllipseArc" (byval xc as integer, byval yc as integer, byval xa as integer, byval ya as integer, byval start as integer, byval end as integer, byval style as integer, byval c as GrColor)
declare sub GrUsrPolyLine cdecl alias "GrUsrPolyLine" (byval numpts as integer, byval points as integer ptr ptr ptr, byval c as GrColor)
declare sub GrUsrPolygon cdecl alias "GrUsrPolygon" (byval numpts as integer, byval points as integer ptr ptr ptr, byval c as GrColor)
declare sub GrUsrFilledConvexPolygon cdecl alias "GrUsrFilledConvexPolygon" (byval numpts as integer, byval points as integer ptr ptr ptr, byval c as GrColor)
declare sub GrUsrFilledPolygon cdecl alias "GrUsrFilledPolygon" (byval numpts as integer, byval points as integer ptr ptr ptr, byval c as GrColor)
declare sub GrUsrFloodFill cdecl alias "GrUsrFloodFill" (byval x as integer, byval y as integer, byval border as GrColor, byval c as GrColor)
declare function GrUsrPixel cdecl alias "GrUsrPixel" (byval x as integer, byval y as integer) as GrColor
declare function GrUsrPixelC cdecl alias "GrUsrPixelC" (byval c as GrContext ptr, byval x as integer, byval y as integer) as GrColor
declare sub GrUsrCustomLine cdecl alias "GrUsrCustomLine" (byval x1 as integer, byval y1 as integer, byval x2 as integer, byval y2 as integer, byval o as GrLineOption ptr)
declare sub GrUsrCustomBox cdecl alias "GrUsrCustomBox" (byval x1 as integer, byval y1 as integer, byval x2 as integer, byval y2 as integer, byval o as GrLineOption ptr)
declare sub GrUsrCustomCircle cdecl alias "GrUsrCustomCircle" (byval xc as integer, byval yc as integer, byval r as integer, byval o as GrLineOption ptr)
declare sub GrUsrCustomEllipse cdecl alias "GrUsrCustomEllipse" (byval xc as integer, byval yc as integer, byval xa as integer, byval ya as integer, byval o as GrLineOption ptr)
declare sub GrUsrCustomCircleArc cdecl alias "GrUsrCustomCircleArc" (byval xc as integer, byval yc as integer, byval r as integer, byval start as integer, byval end as integer, byval style as integer, byval o as GrLineOption ptr)
declare sub GrUsrCustomEllipseArc cdecl alias "GrUsrCustomEllipseArc" (byval xc as integer, byval yc as integer, byval xa as integer, byval ya as integer, byval start as integer, byval end as integer, byval style as integer, byval o as GrLineOption ptr)
declare sub GrUsrCustomPolyLine cdecl alias "GrUsrCustomPolyLine" (byval numpts as integer, byval points as integer ptr ptr ptr, byval o as GrLineOption ptr)
declare sub GrUsrCustomPolygon cdecl alias "GrUsrCustomPolygon" (byval numpts as integer, byval points as integer ptr ptr ptr, byval o as GrLineOption ptr)
declare sub GrUsrPatternedLine cdecl alias "GrUsrPatternedLine" (byval x1 as integer, byval y1 as integer, byval x2 as integer, byval y2 as integer, byval lp as GrLinePattern ptr)
declare sub GrUsrPatternedBox cdecl alias "GrUsrPatternedBox" (byval x1 as integer, byval y1 as integer, byval x2 as integer, byval y2 as integer, byval lp as GrLinePattern ptr)
declare sub GrUsrPatternedCircle cdecl alias "GrUsrPatternedCircle" (byval xc as integer, byval yc as integer, byval r as integer, byval lp as GrLinePattern ptr)
declare sub GrUsrPatternedEllipse cdecl alias "GrUsrPatternedEllipse" (byval xc as integer, byval yc as integer, byval xa as integer, byval ya as integer, byval lp as GrLinePattern ptr)
declare sub GrUsrPatternedCircleArc cdecl alias "GrUsrPatternedCircleArc" (byval xc as integer, byval yc as integer, byval r as integer, byval start as integer, byval end as integer, byval style as integer, byval lp as GrLinePattern ptr)
declare sub GrUsrPatternedEllipseArc cdecl alias "GrUsrPatternedEllipseArc" (byval xc as integer, byval yc as integer, byval xa as integer, byval ya as integer, byval start as integer, byval end as integer, byval style as integer, byval lp as GrLinePattern ptr)
declare sub GrUsrPatternedPolyLine cdecl alias "GrUsrPatternedPolyLine" (byval numpts as integer, byval points as integer ptr ptr ptr, byval lp as GrLinePattern ptr)
declare sub GrUsrPatternedPolygon cdecl alias "GrUsrPatternedPolygon" (byval numpts as integer, byval points as integer ptr ptr ptr, byval lp as GrLinePattern ptr)
declare sub GrUsrPatternFilledPlot cdecl alias "GrUsrPatternFilledPlot" (byval x as integer, byval y as integer, byval p as GrPattern ptr)
declare sub GrUsrPatternFilledLine cdecl alias "GrUsrPatternFilledLine" (byval x1 as integer, byval y1 as integer, byval x2 as integer, byval y2 as integer, byval p as GrPattern ptr)
declare sub GrUsrPatternFilledBox cdecl alias "GrUsrPatternFilledBox" (byval x1 as integer, byval y1 as integer, byval x2 as integer, byval y2 as integer, byval p as GrPattern ptr)
declare sub GrUsrPatternFilledCircle cdecl alias "GrUsrPatternFilledCircle" (byval xc as integer, byval yc as integer, byval r as integer, byval p as GrPattern ptr)
declare sub GrUsrPatternFilledEllipse cdecl alias "GrUsrPatternFilledEllipse" (byval xc as integer, byval yc as integer, byval xa as integer, byval ya as integer, byval p as GrPattern ptr)
declare sub GrUsrPatternFilledCircleArc cdecl alias "GrUsrPatternFilledCircleArc" (byval xc as integer, byval yc as integer, byval r as integer, byval start as integer, byval end as integer, byval style as integer, byval p as GrPattern ptr)
declare sub GrUsrPatternFilledEllipseArc cdecl alias "GrUsrPatternFilledEllipseArc" (byval xc as integer, byval yc as integer, byval xa as integer, byval ya as integer, byval start as integer, byval end as integer, byval style as integer, byval p as GrPattern ptr)
declare sub GrUsrPatternFilledConvexPolygon cdecl alias "GrUsrPatternFilledConvexPolygon" (byval numpts as integer, byval points as integer ptr ptr ptr, byval p as GrPattern ptr)
declare sub GrUsrPatternFilledPolygon cdecl alias "GrUsrPatternFilledPolygon" (byval numpts as integer, byval points as integer ptr ptr ptr, byval p as GrPattern ptr)
declare sub GrUsrPatternFloodFill cdecl alias "GrUsrPatternFloodFill" (byval x as integer, byval y as integer, byval border as GrColor, byval p as GrPattern ptr)
declare sub GrUsrDrawChar cdecl alias "GrUsrDrawChar" (byval chr as integer, byval x as integer, byval y as integer, byval opt as GrTextOption ptr)
declare sub GrUsrDrawString cdecl alias "GrUsrDrawString" (byval text as zstring ptr, byval length as integer, byval x as integer, byval y as integer, byval opt as GrTextOption ptr)
declare sub GrUsrTextXY cdecl alias "GrUsrTextXY" (byval x as integer, byval y as integer, byval text as zstring ptr, byval fg as GrColor, byval bg as GrColor)

type _GR_cursor
	work as _GR_context
	xcord as integer
	ycord as integer
	xsize as integer
	ysize as integer
	xoffs as integer
	yoffs as integer
	xwork as integer
	ywork as integer
	xwpos as integer
	ywpos as integer
	displayed as integer
end type

type GrCursor as _GR_cursor

declare function GrBuildCursor cdecl alias "GrBuildCursor" (byval pixels as zstring ptr, byval pitch as integer, byval w as integer, byval h as integer, byval xo as integer, byval yo as integer, byval c as GrColorTableP) as GrCursor ptr
declare sub GrDestroyCursor cdecl alias "GrDestroyCursor" (byval cursor as GrCursor ptr)
declare sub GrDisplayCursor cdecl alias "GrDisplayCursor" (byval cursor as GrCursor ptr)
declare sub GrEraseCursor cdecl alias "GrEraseCursor" (byval cursor as GrCursor ptr)
declare sub GrMoveCursor cdecl alias "GrMoveCursor" (byval cursor as GrCursor ptr, byval x as integer, byval y as integer)

#define GR_M_MOTION &h001
#define GR_M_LEFT_DOWN &h002
#define GR_M_LEFT_UP &h004
#define GR_M_RIGHT_DOWN &h008
#define GR_M_RIGHT_UP &h010
#define GR_M_MIDDLE_DOWN &h020
#define GR_M_MIDDLE_UP &h040
#define GR_M_BUTTON_DOWN (&h002 or &h020 or &h008)
#define GR_M_BUTTON_UP (&h004 or &h040 or &h010)
#define GR_M_BUTTON_CHANGE ((&h004 or &h040 or &h010) or (&h002 or &h020 or &h008))
#define GR_M_LEFT 1
#define GR_M_RIGHT 2
#define GR_M_MIDDLE 4
#define GR_M_KEYPRESS &h080
#define GR_M_POLL &h100
#define GR_M_NOPAINT &h200
#define GR_M_EVENT (&h001 or &h080 or (&h002 or &h020 or &h008) or (&h004 or &h040 or &h010))
#define GR_KB_RIGHTSHIFT &h01
#define GR_KB_LEFTSHIFT &h02
#define GR_KB_CTRL &h04
#define GR_KB_ALT &h08
#define GR_KB_SCROLLOCK &h10
#define GR_KB_NUMLOCK &h20
#define GR_KB_CAPSLOCK &h40
#define GR_KB_INSERT &h80
#define GR_KB_SHIFT (&h02 or &h01)
#define GR_M_CUR_NORMAL 0
#define GR_M_CUR_RUBBER 1
#define GR_M_CUR_LINE 2
#define GR_M_CUR_BOX 3
#define GR_M_QUEUE_SIZE 128

type _GR_mouseEvent
	flags as integer
	x as integer
	y as integer
	buttons as integer
	key as integer
	kbstat as integer
	dtime as integer
end type

type GrMouseEvent as _GR_mouseEvent

type _GR_mouseInfo
	block as function cdecl(byval as GrContext ptr, byval as integer, byval as integer, byval as integer, byval as integer) as integer
	unblock as sub cdecl(byval as integer)
	uninit as sub cdecl()
	cursor as _GR_cursor ptr
	queue as _GR_mouseEvent ptr
	msstatus as integer
	displayed as integer
	blockflag as integer
	docheck as integer
	cursmode as integer
	x1 as integer
	y1 as integer
	x2 as integer
	y2 as integer
	curscolor as GrColor
	owncursor as integer
	xpos as integer
	ypos as integer
	xmin as integer
	xmax as integer
	ymin as integer
	ymax as integer
	spmult as integer
	spdiv as integer
	thresh as integer
	accel as integer
	moved as integer
	qsize as integer
	qlength as integer
	qread as integer
	qwrite as integer
end type

extern GrMouseInfo alias "GrMouseInfo" as _GR_mouseInfo ptr

declare function GrMouseDetect cdecl alias "GrMouseDetect" () as integer
declare sub GrMouseEventMode cdecl alias "GrMouseEventMode" (byval dummy as integer)
declare sub GrMouseInit cdecl alias "GrMouseInit" ()
declare sub GrMouseInitN cdecl alias "GrMouseInitN" (byval queue_size as integer)
declare sub GrMouseUnInit cdecl alias "GrMouseUnInit" ()
declare sub GrMouseSetSpeed cdecl alias "GrMouseSetSpeed" (byval spmult as integer, byval spdiv as integer)
declare sub GrMouseSetAccel cdecl alias "GrMouseSetAccel" (byval thresh as integer, byval accel as integer)
declare sub GrMouseSetLimits cdecl alias "GrMouseSetLimits" (byval x1 as integer, byval y1 as integer, byval x2 as integer, byval y2 as integer)
declare sub GrMouseGetLimits cdecl alias "GrMouseGetLimits" (byval x1 as integer ptr, byval y1 as integer ptr, byval x2 as integer ptr, byval y2 as integer ptr)
declare sub GrMouseWarp cdecl alias "GrMouseWarp" (byval x as integer, byval y as integer)
declare sub GrMouseEventEnable cdecl alias "GrMouseEventEnable" (byval enable_kb as integer, byval enable_ms as integer)
declare sub GrMouseGetEvent cdecl alias "GrMouseGetEvent" (byval flags as integer, byval event as GrMouseEvent ptr)
declare sub GrMouseGetEventT cdecl alias "GrMouseGetEventT" (byval flags as integer, byval event as GrMouseEvent ptr, byval timout_msecs as integer)
declare function GrMousePendingEvent cdecl alias "GrMousePendingEvent" () as integer
declare function GrMouseGetCursor cdecl alias "GrMouseGetCursor" () as GrCursor ptr
declare sub GrMouseSetCursor cdecl alias "GrMouseSetCursor" (byval cursor as GrCursor ptr)
declare sub GrMouseSetColors cdecl alias "GrMouseSetColors" (byval fg as GrColor, byval bg as GrColor)
declare sub GrMouseSetCursorMode cdecl alias "GrMouseSetCursorMode" (byval mode as integer, ...)
declare sub GrMouseDisplayCursor cdecl alias "GrMouseDisplayCursor" ()
declare sub GrMouseEraseCursor cdecl alias "GrMouseEraseCursor" ()
declare sub GrMouseUpdateCursor cdecl alias "GrMouseUpdateCursor" ()
declare function GrMouseCursorIsDisplayed cdecl alias "GrMouseCursorIsDisplayed" () as integer
declare function GrMouseBlock cdecl alias "GrMouseBlock" (byval c as GrContext ptr, byval x1 as integer, byval y1 as integer, byval x2 as integer, byval y2 as integer) as integer
declare sub GrMouseUnBlock cdecl alias "GrMouseUnBlock" (byval return_value_from_GrMouseBlock as integer)

#define PLAINPBMFORMAT 1
#define PLAINPGMFORMAT 2
#define PLAINPPMFORMAT 3
#define PBMFORMAT 4
#define PGMFORMAT 5
#define PPMFORMAT 6

declare function GrSaveContextToPbm cdecl alias "GrSaveContextToPbm" (byval grc as GrContext ptr, byval pbmfn as zstring ptr, byval docn as zstring ptr) as integer
declare function GrSaveContextToPgm cdecl alias "GrSaveContextToPgm" (byval grc as GrContext ptr, byval pgmfn as zstring ptr, byval docn as zstring ptr) as integer
declare function GrSaveContextToPpm cdecl alias "GrSaveContextToPpm" (byval grc as GrContext ptr, byval ppmfn as zstring ptr, byval docn as zstring ptr) as integer
declare function GrLoadContextFromPnm cdecl alias "GrLoadContextFromPnm" (byval grc as GrContext ptr, byval pnmfn as zstring ptr) as integer
declare function GrQueryPnm cdecl alias "GrQueryPnm" (byval pnmfn as zstring ptr, byval width as integer ptr, byval height as integer ptr, byval maxval as integer ptr) as integer
declare function GrLoadContextFromPnmBuffer cdecl alias "GrLoadContextFromPnmBuffer" (byval grc as GrContext ptr, byval buffer as zstring ptr) as integer
declare function GrQueryPnmBuffer cdecl alias "GrQueryPnmBuffer" (byval buffer as zstring ptr, byval width as integer ptr, byval height as integer ptr, byval maxval as integer ptr) as integer
declare function GrPngSupport cdecl alias "GrPngSupport" () as integer
declare function GrSaveContextToPng cdecl alias "GrSaveContextToPng" (byval grc as GrContext ptr, byval pngfn as zstring ptr) as integer
declare function GrLoadContextFromPng cdecl alias "GrLoadContextFromPng" (byval grc as GrContext ptr, byval pngfn as zstring ptr, byval use_alpha as integer) as integer
declare function GrQueryPng cdecl alias "GrQueryPng" (byval pngfn as zstring ptr, byval width as integer ptr, byval height as integer ptr) as integer
declare function GrJpegSupport cdecl alias "GrJpegSupport" () as integer
declare function GrLoadContextFromJpeg cdecl alias "GrLoadContextFromJpeg" (byval grc as GrContext ptr, byval jpegfn as zstring ptr, byval scale as integer) as integer
declare function GrQueryJpeg cdecl alias "GrQueryJpeg" (byval jpegfn as zstring ptr, byval width as integer ptr, byval height as integer ptr) as integer
declare function GrSaveContextToJpeg cdecl alias "GrSaveContextToJpeg" (byval grc as GrContext ptr, byval jpegfn as zstring ptr, byval quality as integer) as integer
declare function GrSaveContextToGrayJpeg cdecl alias "GrSaveContextToGrayJpeg" (byval grc as GrContext ptr, byval jpegfn as zstring ptr, byval quality as integer) as integer
declare sub GrResizeGrayMap cdecl alias "GrResizeGrayMap" (byval map as ubyte ptr, byval pitch as integer, byval ow as integer, byval oh as integer, byval nw as integer, byval nh as integer)
declare function GrMatchString cdecl alias "GrMatchString" (byval pattern as zstring ptr, byval strg as zstring ptr) as integer
declare sub GrSetWindowTitle cdecl alias "GrSetWindowTitle" (byval title as zstring ptr)
declare sub GrSleep cdecl alias "GrSleep" (byval msec as integer)

declare function SaveContextToTiff cdecl alias "SaveContextToTiff" (byval cxt as GrContext ptr, byval tiffn as zstring ptr, byval compr as uinteger, byval docn as zstring ptr) as integer

#endif
