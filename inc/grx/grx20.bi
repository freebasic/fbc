'' FreeBASIC binding for GRX 2.4.9
''
'' based on the C header files:
''
''   * grx20.h ---- GRX 2.x API functions and data structure declarations
''   *
''   * Copyright (c) 1995 Csaba Biegl, 820 Stirrup Dr, Nashville, TN 37221
''   * [e-mail: csaba@vuse.vanderbilt.edu]
''   *
''   * This file is part of the GRX graphics library.
''   *
''   * The GRX graphics library is free software; you can redistribute it
''   * and/or modify it under some conditions; see the "copying.grx" file
''   * for details.
''   *
''   * This library is distributed in the hope that it will be useful,
''   * but WITHOUT ANY WARRANTY; without even the implied warranty of
''   * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.
''   *
''
''
''   Source code with the above copyright is distributed under the following terms:
''
''    (1) The test programs for the graphics library (code in the 'test'
''        sub-directory) is distributed without restrictions. This code
''        is free for use in commercial, shareware or freeware applications.
''
''    (2) The GRX graphics library is distributed under the terms of the
''        GNU LGPL (Library General Public License) with the following amendments
''        and/or exceptions:
''
''        -  Using the DOS versions (DOS only! this exception DOES NOT apply to
''   	the Linux version) you are permitted to distribute an application
''   	linked with GRX in binary only, provided that the documentation
''   	of the program:
''
''   	   a)	informs the user that GRX is used in the program, AND
''
''   	   b)	provides the user with the necessary information about
''   		how to obtain GRX. (i.e. ftp site, etc..)
''
''    (3) Fonts (in the 'fonts' sub-directory). Most of the fonts included with
''        the GRX library were derived from fonts in the MIT X11R4 distribution.
''        They are distributed according to the terms in the file "COPYING.MIT"
''        (X license). Exceptions are:
''        - The fonts "ter-114b.res", "ter-114n.fna" and "ter-114v.psf" are
''          Copyright (C) 2002 Dimitar Zhekov, but are distributed under the
''          X license too.
''        - The "pc" BIOS font family, which is distributed without restrictions.
''
''   A copy of the GNU GPL (in the file "COPYING") and the GNU LGPL (in
''   the file "COPYING.LIB") is included with this document. If you did
''   not receive a copy of "COPYING" or "COPYING.LIB", you may obtain one 
''   from where this document was obtained, or by writing to:
''
''     Free Software Foundation
''     675 Mass Ave
''     Cambridge, MA 02139
''     USA
''
''
'' translated to FreeBASIC by:
''   Copyright © 2015 FreeBASIC development team

#pragma once

#inclib "grx20"

#ifdef __FB_WIN32__
	#inclib "gdi32"
	#inclib "user32"
#endif

#include once "crt/long.bi"

extern "C"

#define __GRX20_H_INCLUDED__
const GRX_VERSION_API = &h0249
const GRX_VERSION_TCC_8086_DOS = 1
const GRX_VERSION_GCC_386_GO32 = 2
const GRX_VERSION_GCC_386_DJGPP = 2
const GRX_VERSION_GCC_386_LINUX = 3
const GRX_VERSION_GENERIC_X11 = 4
const GRX_VERSION_WATCOM_DOS4GW = 5
const GRX_VERSION_GCC_386_WIN32 = 7
const GRX_VERSION_MSC_386_WIN32 = 8
const GRX_VERSION_GCC_386_CYG32 = 9
const GRX_VERSION_GCC_386_X11 = 10
const GRX_VERSION_GCC_X86_64_LINUX = 11
const GRX_VERSION_GCC_X86_64_X11 = 12
#define GRXMain main

#if defined(__FB_LINUX__) and (not defined(__FB_64BIT__)) and (not defined(__FB_ARM__))
	const GRX_VERSION = GRX_VERSION_GCC_386_LINUX
#elseif defined(__FB_LINUX__) and defined(__FB_64BIT__) and (not defined(__FB_ARM__))
	const GRX_VERSION = GRX_VERSION_GCC_X86_64_LINUX
#elseif (defined(__FB_64BIT__) and (defined(__FB_DARWIN__) or defined(__FB_CYGWIN__) or (defined(__FB_ARM__) and (defined(__FB_LINUX__) or defined(__FB_FREEBSD__) or defined(__FB_OPENBSD__) or defined(__FB_NETBSD__))) or ((not defined(__FB_ARM__)) and (defined(__FB_FREEBSD__) or defined(__FB_OPENBSD__) or defined(__FB_NETBSD__))))) or ((not defined(__FB_64BIT__)) and (defined(__FB_DARWIN__) or (defined(__FB_ARM__) and (defined(__FB_LINUX__) or defined(__FB_FREEBSD__) or defined(__FB_OPENBSD__) or defined(__FB_NETBSD__))) or ((not defined(__FB_ARM__)) and (defined(__FB_FREEBSD__) or defined(__FB_OPENBSD__) or defined(__FB_NETBSD__)))))
	const GRX_VERSION = GRX_VERSION_GENERIC_X11
#elseif defined(__FB_WIN32__)
	const GRX_VERSION = GRX_VERSION_GCC_386_WIN32
#elseif defined(__FB_CYGWIN__) and (not defined(__FB_64BIT__))
	const GRX_VERSION = GRX_VERSION_GCC_386_CYG32
	#define __WIN32__
#else
	const GRX_VERSION = GRX_VERSION_GCC_386_DJGPP
#endif

type _GR_frameDriver as _GR_frameDriver_
type GrFrameDriver as _GR_frameDriver
type GrVideoDriver as _GR_videoDriver
type _GR_videoMode as _GR_videoMode_
type GrVideoMode as _GR_videoMode
type _GR_videoModeExt as _GR_videoModeExt_
type GrVideoModeExt as _GR_videoModeExt
type GrFrame as _GR_frame
type GrContext as _GR_context
type GrColor as ulong

type _GR_graphicsModes as long
enum
	GR_unknown_mode = -1
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

type _GR_frameModes as long
enum
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
	GR_frameSDL8 = GR_frameSVGA8
	GR_frameSDL16 = GR_frameSVGA16
	GR_frameSDL24 = GR_frameSVGA24
	GR_frameSDL32L = GR_frameSVGA32L
	GR_frameSDL32H = GR_frameSVGA32H
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

type _GR_videoAdapters as long
enum
	GR_UNKNOWN = -1
	GR_VGA
	GR_EGA
	GR_HERC
	GR_8514A
	GR_S3
	GR_XWIN
	GR_WIN32
	GR_LNXFB
	GR_SDL
	GR_MEM
end enum

type GrVideoAdapter as _GR_videoAdapters

type _GR_videoDriver
	name as zstring ptr
	adapter as _GR_videoAdapters
	inherit as _GR_videoDriver ptr
	modes as _GR_videoMode ptr
	nmodes as long
	detect as function() as long
	init as function(byval options as zstring ptr) as long
	reset as sub()
	selectmode as function(byval drv as GrVideoDriver ptr, byval w as long, byval h as long, byval bpp as long, byval txt as long, byval ep as ulong ptr) as GrVideoMode ptr
	drvflags as ulong
end type

const GR_DRIVERF_USER_RESOLUTION = 1

type _GR_videoMode_
	present as byte
	bpp as byte
	width as short
	height as short
	mode as short
	lineoffset as long
	privdata as long
	extinfo as _GR_videoModeExt ptr
end type

type _GR_videoModeExt_
	mode as _GR_frameModes
	drv as _GR_frameDriver ptr
	frame as zstring ptr
	cprec as zstring * 3
	cpos as zstring * 3
	flags as long
	setup as function(byval md as GrVideoMode ptr, byval noclear as long) as long
	setvsize as function(byval md as GrVideoMode ptr, byval w as long, byval h as long, byval result as GrVideoMode ptr) as long
	scroll as function(byval md as GrVideoMode ptr, byval x as long, byval y as long, byval result as long ptr) as long
	setbank as sub(byval bk as long)
	setrwbanks as sub(byval rb as long, byval wb as long)
	loadcolor as sub(byval c as long, byval r as long, byval g as long, byval b as long)
	LFB_Selector as long
end type

type _GR_frameDriver_
	mode as _GR_frameModes
	rmode as _GR_frameModes
	is_video as long
	row_align as long
	num_planes as long
	bits_per_pixel as long
	max_plane_size as clong
	init as function(byval md as GrVideoMode ptr) as long
	readpixel as function(byval c as GrFrame ptr, byval x as long, byval y as long) as GrColor
	drawpixel as sub(byval x as long, byval y as long, byval c as GrColor)
	drawline as sub(byval x as long, byval y as long, byval dx as long, byval dy as long, byval c as GrColor)
	drawhline as sub(byval x as long, byval y as long, byval w as long, byval c as GrColor)
	drawvline as sub(byval x as long, byval y as long, byval h as long, byval c as GrColor)
	drawblock as sub(byval x as long, byval y as long, byval w as long, byval h as long, byval c as GrColor)
	drawbitmap as sub(byval x as long, byval y as long, byval w as long, byval h as long, byval bmp as zstring ptr, byval pitch as long, byval start as long, byval fg as GrColor, byval bg as GrColor)
	drawpattern as sub(byval x as long, byval y as long, byval w as long, byval patt as byte, byval fg as GrColor, byval bg as GrColor)
	bitblt as sub(byval dst as GrFrame ptr, byval dx as long, byval dy as long, byval src as GrFrame ptr, byval x as long, byval y as long, byval w as long, byval h as long, byval op as GrColor)
	bltv2r as sub(byval dst as GrFrame ptr, byval dx as long, byval dy as long, byval src as GrFrame ptr, byval x as long, byval y as long, byval w as long, byval h as long, byval op as GrColor)
	bltr2v as sub(byval dst as GrFrame ptr, byval dx as long, byval dy as long, byval src as GrFrame ptr, byval x as long, byval y as long, byval w as long, byval h as long, byval op as GrColor)
	getindexedscanline as function(byval c as GrFrame ptr, byval x as long, byval y as long, byval w as long, byval indx as long ptr) as GrColor ptr
	putscanline as sub(byval x as long, byval y as long, byval w as long, byval scl as const GrColor ptr, byval op as GrColor)
end type

type _GR_driverInfo
	vdriver as _GR_videoDriver ptr
	curmode as _GR_videoMode ptr
	actmode as _GR_videoMode
	fdriver as _GR_frameDriver
	sdriver as _GR_frameDriver
	tdriver as _GR_frameDriver
	mcode as _GR_graphicsModes
	deftw as long
	defth as long
	defgw as long
	defgh as long
	deftc as GrColor
	defgc as GrColor
	vposx as long
	vposy as long
	errsfatal as long
	moderestore as long
	splitbanks as long
	curbank as long
	mdsethook as sub()
	setbank as sub(byval bk as long)
	setrwbanks as sub(byval rb as long, byval wb as long)
end type

extern GrDriverInfo as const _GR_driverInfo const ptr
declare function GrSetDriver(byval drvspec as zstring ptr) as long
declare function GrSetMode(byval which as GrGraphicsMode, ...) as long
declare function GrSetViewport(byval xpos as long, byval ypos as long) as long
declare sub GrSetModeHook(byval hookfunc as sub())
declare sub GrSetModeRestore(byval restoreFlag as long)
declare sub GrSetErrorHandling(byval exitIfError as long)
declare sub GrSetEGAVGAmonoDrawnPlane(byval plane as long)
declare sub GrSetEGAVGAmonoShownPlane(byval plane as long)
declare function GrGetLibraryVersion() as ulong
declare function GrGetLibrarySystem() as ulong
declare function GrCurrentMode() as GrGraphicsMode
declare function GrAdapterType() as GrVideoAdapter
declare function GrCurrentFrameMode() as GrFrameMode
declare function GrScreenFrameMode() as GrFrameMode
declare function GrCoreFrameMode() as GrFrameMode
declare function GrCurrentVideoDriver() as const GrVideoDriver ptr
declare function GrCurrentVideoMode() as const GrVideoMode ptr
declare function GrVirtualVideoMode() as const GrVideoMode ptr
declare function GrCurrentFrameDriver() as const GrFrameDriver ptr
declare function GrScreenFrameDriver() as const GrFrameDriver ptr
declare function GrFirstVideoMode(byval fmode as GrFrameMode) as const GrVideoMode ptr
declare function GrNextVideoMode(byval prev as const GrVideoMode ptr) as const GrVideoMode ptr
declare function GrScreenX() as long
declare function GrScreenY() as long
declare function GrVirtualX() as long
declare function GrVirtualY() as long
declare function GrViewportX() as long
declare function GrViewportY() as long
declare function GrScreenIsVirtual() as long
declare function GrFrameNumPlanes(byval md as GrFrameMode) as long
declare function GrFrameLineOffset(byval md as GrFrameMode, byval width as long) as long
declare function GrFramePlaneSize(byval md as GrFrameMode, byval w as long, byval h as long) as clong
declare function GrFrameContextSize(byval md as GrFrameMode, byval w as long, byval h as long) as clong
declare function GrNumPlanes() as long
declare function GrLineOffset(byval width as long) as long
declare function GrPlaneSize(byval w as long, byval h as long) as clong
declare function GrContextSize(byval w as long, byval h as long) as clong

type _GR_frame
	gf_baseaddr(0 to 3) as zstring ptr
	gf_selector as short
	gf_onscreen as byte
	gf_memflags as byte
	gf_lineoffset as long
	gf_driver as _GR_frameDriver ptr
end type

type _GR_context
	gc_frame as _GR_frame
	gc_root as _GR_context ptr
	gc_xmax as long
	gc_ymax as long
	gc_xoffset as long
	gc_yoffset as long
	gc_xcliplo as long
	gc_ycliplo as long
	gc_xcliphi as long
	gc_ycliphi as long
	gc_usrxbase as long
	gc_usrybase as long
	gc_usrwidth as long
	gc_usrheight as long
end type

#define gc_baseaddr gc_frame.gf_baseaddr
#define gc_selector gc_frame.gf_selector
#define gc_onscreen gc_frame.gf_onscreen
#define gc_memflags gc_frame.gf_memflags
#define gc_lineoffset gc_frame.gf_lineoffset
#define gc_driver gc_frame.gf_driver

type _GR_contextInfo
	current as _GR_context
	screen as _GR_context
end type

extern GrContextInfo as const _GR_contextInfo const ptr
declare function GrCreateContext(byval w as long, byval h as long, byval memory as zstring ptr ptr, byval where as GrContext ptr) as GrContext ptr
declare function GrCreateFrameContext(byval md as GrFrameMode, byval w as long, byval h as long, byval memory as zstring ptr ptr, byval where as GrContext ptr) as GrContext ptr
declare function GrCreateSubContext(byval x1 as long, byval y1 as long, byval x2 as long, byval y2 as long, byval parent as const GrContext ptr, byval where as GrContext ptr) as GrContext ptr
declare function GrSaveContext(byval where as GrContext ptr) as GrContext ptr
declare function GrCurrentContext() as GrContext ptr
declare function GrScreenContext() as GrContext ptr
declare sub GrDestroyContext(byval context as GrContext ptr)
declare sub GrResizeSubContext(byval context as GrContext ptr, byval x1 as long, byval y1 as long, byval x2 as long, byval y2 as long)
declare sub GrSetContext(byval context as const GrContext ptr)
declare sub GrSetClipBox(byval x1 as long, byval y1 as long, byval x2 as long, byval y2 as long)
declare sub GrSetClipBoxC(byval c as GrContext ptr, byval x1 as long, byval y1 as long, byval x2 as long, byval y2 as long)
declare sub GrGetClipBox(byval x1p as long ptr, byval y1p as long ptr, byval x2p as long ptr, byval y2p as long ptr)
declare sub GrGetClipBoxC(byval c as const GrContext ptr, byval x1p as long ptr, byval y1p as long ptr, byval x2p as long ptr, byval y2p as long ptr)
declare sub GrResetClipBox()
declare sub GrResetClipBoxC(byval c as GrContext ptr)
declare function GrMaxX() as long
declare function GrMaxY() as long
declare function GrSizeX() as long
declare function GrSizeY() as long
declare function GrLowX() as long
declare function GrLowY() as long
declare function GrHighX() as long
declare function GrHighY() as long

const GrWRITE = cast(culong, 0)
const GrXOR = cast(culong, &h01000000)
const GrOR = cast(culong, &h02000000)
const GrAND = cast(culong, &h03000000)
const GrIMAGE = cast(culong, &h04000000)
const GrCVALUEMASK = cast(culong, &h00ffffff)
const GrCMODEMASK = cast(culong, &hff000000)
const GrNOCOLOR = GrXOR or 0

declare function GrColorValue(byval c as GrColor) as GrColor
declare function GrColorMode(byval c as GrColor) as GrColor
declare function GrWriteModeColor(byval c as GrColor) as GrColor
declare function GrXorModeColor(byval c as GrColor) as GrColor
declare function GrOrModeColor(byval c as GrColor) as GrColor
declare function GrAndModeColor(byval c as GrColor) as GrColor
declare function GrImageModeColor(byval c as GrColor) as GrColor

type _GR_colorInfo_ctable
	r as ubyte
	g as ubyte
	b as ubyte
	defined : 1 as ulong
	writable : 1 as ulong
	nused as culong
end type

type _GR_colorInfo
	ncolors as GrColor
	nfree as GrColor
	black as GrColor
	white as GrColor
	RGBmode as ulong
	prec(0 to 2) as ulong
	pos(0 to 2) as ulong
	mask(0 to 2) as ulong
	round(0 to 2) as ulong
	shift(0 to 2) as ulong
	norm as ulong
	ctable(0 to 255) as _GR_colorInfo_ctable
end type

extern GrColorInfo as const _GR_colorInfo const ptr
declare sub GrResetColors()
declare sub GrSetRGBcolorMode()
declare sub GrRefreshColors()
declare function GrNumColors() as GrColor
declare function GrNumFreeColors() as GrColor
declare function GrBlack() as GrColor
declare function GrWhite() as GrColor
declare function GrBuildRGBcolorT(byval r as long, byval g as long, byval b as long) as GrColor
declare function GrBuildRGBcolorR(byval r as long, byval g as long, byval b as long) as GrColor
declare function GrRGBcolorRed(byval c as GrColor) as long
declare function GrRGBcolorGreen(byval c as GrColor) as long
declare function GrRGBcolorBlue(byval c as GrColor) as long
declare function GrAllocColor(byval r as long, byval g as long, byval b as long) as GrColor
declare function GrAllocColorID(byval r as long, byval g as long, byval b as long) as GrColor
declare function GrAllocColor2(byval hcolor as clong) as GrColor
declare function GrAllocColor2ID(byval hcolor as clong) as GrColor
declare function GrAllocCell() as GrColor
declare function GrAllocEgaColors() as GrColor ptr
declare sub GrSetColor(byval c as GrColor, byval r as long, byval g as long, byval b as long)
declare sub GrFreeColor(byval c as GrColor)
declare sub GrFreeCell(byval c as GrColor)
declare sub GrQueryColor(byval c as GrColor, byval r as long ptr, byval g as long ptr, byval b as long ptr)
declare sub GrQueryColorID(byval c as GrColor, byval r as long ptr, byval g as long ptr, byval b as long ptr)
declare sub GrQueryColor2(byval c as GrColor, byval hcolor as clong ptr)
declare sub GrQueryColor2ID(byval c as GrColor, byval hcolor as clong ptr)
declare function GrColorSaveBufferSize() as long
declare sub GrSaveColors(byval buffer as any ptr)
declare sub GrRestoreColors(byval buffer as any ptr)
type GrColorTableP as GrColor ptr

#define GR_CTABLE_SIZE(table) culng(iif((table), culng((table)[0]), 0u))
#define GR_CTABLE_COLOR(table, index) iif(culng(index) < GR_CTABLE_SIZE(table), (table)[culng(culng(index) + 1)], GrNOCOLOR)
#define GR_CTABLE_ALLOCSIZE(ncolors) ((ncolors) + 1)
const GR_MAX_POLYGON_POINTS = 1000000
const GR_MAX_ELLIPSE_POINTS = 1024 + 5
const GR_MAX_ANGLE_VALUE = 3600
const GR_ARC_STYLE_OPEN = 0
const GR_ARC_STYLE_CLOSE1 = 1
const GR_ARC_STYLE_CLOSE2 = 2

type GrFBoxColors
	fbx_intcolor as GrColor
	fbx_topcolor as GrColor
	fbx_rightcolor as GrColor
	fbx_bottomcolor as GrColor
	fbx_leftcolor as GrColor
end type

declare sub GrClearScreen(byval bg as GrColor)
declare sub GrClearContext(byval bg as GrColor)
declare sub GrClearContextC(byval ctx as GrContext ptr, byval bg as GrColor)
declare sub GrClearClipBox(byval bg as GrColor)
declare sub GrPlot(byval x as long, byval y as long, byval c as GrColor)
declare sub GrLine(byval x1 as long, byval y1 as long, byval x2 as long, byval y2 as long, byval c as GrColor)
declare sub GrHLine(byval x1 as long, byval x2 as long, byval y as long, byval c as GrColor)
declare sub GrVLine(byval x as long, byval y1 as long, byval y2 as long, byval c as GrColor)
declare sub GrBox(byval x1 as long, byval y1 as long, byval x2 as long, byval y2 as long, byval c as GrColor)
declare sub GrFilledBox(byval x1 as long, byval y1 as long, byval x2 as long, byval y2 as long, byval c as GrColor)
declare sub GrFramedBox(byval x1 as long, byval y1 as long, byval x2 as long, byval y2 as long, byval wdt as long, byval c as const GrFBoxColors ptr)
declare function GrGenerateEllipse(byval xc as long, byval yc as long, byval xa as long, byval ya as long, byval points as long ptr) as long
declare function GrGenerateEllipseArc(byval xc as long, byval yc as long, byval xa as long, byval ya as long, byval start as long, byval end as long, byval points as long ptr) as long
declare sub GrLastArcCoords(byval xs as long ptr, byval ys as long ptr, byval xe as long ptr, byval ye as long ptr, byval xc as long ptr, byval yc as long ptr)
declare sub GrCircle(byval xc as long, byval yc as long, byval r as long, byval c as GrColor)
declare sub GrEllipse(byval xc as long, byval yc as long, byval xa as long, byval ya as long, byval c as GrColor)
declare sub GrCircleArc(byval xc as long, byval yc as long, byval r as long, byval start as long, byval end as long, byval style as long, byval c as GrColor)
declare sub GrEllipseArc(byval xc as long, byval yc as long, byval xa as long, byval ya as long, byval start as long, byval end as long, byval style as long, byval c as GrColor)
declare sub GrFilledCircle(byval xc as long, byval yc as long, byval r as long, byval c as GrColor)
declare sub GrFilledEllipse(byval xc as long, byval yc as long, byval xa as long, byval ya as long, byval c as GrColor)
declare sub GrFilledCircleArc(byval xc as long, byval yc as long, byval r as long, byval start as long, byval end as long, byval style as long, byval c as GrColor)
declare sub GrFilledEllipseArc(byval xc as long, byval yc as long, byval xa as long, byval ya as long, byval start as long, byval end as long, byval style as long, byval c as GrColor)
declare sub GrPolyLine(byval numpts as long, byval points as long ptr, byval c as GrColor)
declare sub GrPolygon(byval numpts as long, byval points as long ptr, byval c as GrColor)
declare sub GrFilledConvexPolygon(byval numpts as long, byval points as long ptr, byval c as GrColor)
declare sub GrFilledPolygon(byval numpts as long, byval points as long ptr, byval c as GrColor)
declare sub GrBitBlt(byval dst as GrContext ptr, byval x as long, byval y as long, byval src as GrContext ptr, byval x1 as long, byval y1 as long, byval x2 as long, byval y2 as long, byval op as GrColor)
declare sub GrBitBlt1bpp(byval dst as GrContext ptr, byval dx as long, byval dy as long, byval src as GrContext ptr, byval x1 as long, byval y1 as long, byval x2 as long, byval y2 as long, byval fg as GrColor, byval bg as GrColor)
declare sub GrFloodFill(byval x as long, byval y as long, byval border as GrColor, byval c as GrColor)
declare sub GrFloodSpill(byval x1 as long, byval y1 as long, byval x2 as long, byval y2 as long, byval old_c as GrColor, byval new_c as GrColor)
declare sub GrFloodSpill2(byval x1 as long, byval y1 as long, byval x2 as long, byval y2 as long, byval old_c1 as GrColor, byval new_c1 as GrColor, byval old_c2 as GrColor, byval new_c2 as GrColor)
declare sub GrFloodSpillC(byval ctx as GrContext ptr, byval x1 as long, byval y1 as long, byval x2 as long, byval y2 as long, byval old_c as GrColor, byval new_c as GrColor)
declare sub GrFloodSpillC2(byval ctx as GrContext ptr, byval x1 as long, byval y1 as long, byval x2 as long, byval y2 as long, byval old_c1 as GrColor, byval new_c1 as GrColor, byval old_c2 as GrColor, byval new_c2 as GrColor)
declare function GrPixel(byval x as long, byval y as long) as GrColor
declare function GrPixelC(byval c as GrContext ptr, byval x as long, byval y as long) as GrColor
declare function GrGetScanline(byval x1 as long, byval x2 as long, byval yy as long) as const GrColor ptr
declare function GrGetScanlineC(byval ctx as GrContext ptr, byval x1 as long, byval x2 as long, byval yy as long) as const GrColor ptr
declare sub GrPutScanline(byval x1 as long, byval x2 as long, byval yy as long, byval c as const GrColor ptr, byval op as GrColor)
declare sub GrPlotNC(byval x as long, byval y as long, byval c as GrColor)
declare sub GrLineNC(byval x1 as long, byval y1 as long, byval x2 as long, byval y2 as long, byval c as GrColor)
declare sub GrHLineNC(byval x1 as long, byval x2 as long, byval y as long, byval c as GrColor)
declare sub GrVLineNC(byval x as long, byval y1 as long, byval y2 as long, byval c as GrColor)
declare sub GrBoxNC(byval x1 as long, byval y1 as long, byval x2 as long, byval y2 as long, byval c as GrColor)
declare sub GrFilledBoxNC(byval x1 as long, byval y1 as long, byval x2 as long, byval y2 as long, byval c as GrColor)
declare sub GrFramedBoxNC(byval x1 as long, byval y1 as long, byval x2 as long, byval y2 as long, byval wdt as long, byval c as const GrFBoxColors ptr)
declare sub GrBitBltNC(byval dst as GrContext ptr, byval x as long, byval y as long, byval src as GrContext ptr, byval x1 as long, byval y1 as long, byval x2 as long, byval y2 as long, byval op as GrColor)
declare function GrPixelNC(byval x as long, byval y as long) as GrColor
declare function GrPixelCNC(byval c as GrContext ptr, byval x as long, byval y as long) as GrColor

const GR_TEXT_RIGHT = 0
const GR_TEXT_DOWN = 1
const GR_TEXT_LEFT = 2
const GR_TEXT_UP = 3
const GR_TEXT_DEFAULT = GR_TEXT_RIGHT
#define GR_TEXT_IS_VERTICAL(d) ((d) and 1)
const GR_ALIGN_LEFT = 0
const GR_ALIGN_TOP = 0
const GR_ALIGN_CENTER = 1
const GR_ALIGN_RIGHT = 2
const GR_ALIGN_BOTTOM = 2
const GR_ALIGN_BASELINE = 3
const GR_ALIGN_DEFAULT = GR_ALIGN_LEFT
const GR_BYTE_TEXT = 0
const GR_WORD_TEXT = 1
const GR_ATTR_TEXT = 2
#define GR_TEXTCHR_SIZE(ty) iif((ty) = GR_BYTE_TEXT, sizeof(byte), sizeof(short))
#define GR_TEXTCHR_CODE(ch, ty) iif((ty) = GR_WORD_TEXT, cushort(ch), cubyte(ch))
#define GR_TEXTCHR_ATTR(ch, ty) iif((ty) = GR_ATTR_TEXT, cushort(ch) shr 8, 0)
#define GR_TEXTSTR_CODE(pt, ty) iif((ty) = GR_WORD_TEXT, cptr(ushort ptr, (pt))[0], cptr(ubyte ptr, (pt))[0])
#define GR_TEXTSTR_ATTR(pt, ty) iif((ty) = GR_ATTR_TEXT, cptr(ubyte ptr, (pt))[1], 0)
extern _GR_textattrintensevideo as long
#define GR_BUILD_ATTR(fg, bg, ul) iif(_GR_textattrintensevideo, ((fg) and 15) or (((bg) and 15) shl 4), (((fg) and 15) or (((bg) and 7) shl 4)) or iif((ul), 128, 0))
#define GR_ATTR_FGCOLOR(attr) ((attr) and 15)
#define GR_ATTR_BGCOLOR(attr) iif(_GR_textattrintensevideo, ((attr) shr 4) and 15, ((attr) shr 4) and 7)
#define GR_ATTR_UNDERLINE(attr) iif(_GR_textattrintensevideo, 0, (attr) and 128)
const GR_UNDERLINE_TEXT = GrXOR shl 4
const GR_FONTCVT_NONE = 0
const GR_FONTCVT_SKIPCHARS = 1
const GR_FONTCVT_RESIZE = 2
const GR_FONTCVT_ITALICIZE = 4
const GR_FONTCVT_BOLDIFY = 8
const GR_FONTCVT_FIXIFY = 16
const GR_FONTCVT_PROPORTION = 32

type _GR_fontHeader
	name as zstring ptr
	family as zstring ptr
	proportional as byte
	scalable as byte
	preloaded as byte
	modified as byte
	width as ulong
	height as ulong
	baseline as ulong
	ulpos as ulong
	ulheight as ulong
	minchar as ulong
	numchars as ulong
end type

type GrFontHeader as _GR_fontHeader

type _GR_fontChrInfo
	width as ulong
	offset as ulong
end type

type GrFontChrInfo as _GR_fontChrInfo

type _GR_font
	h as _GR_fontHeader
	bitmap as zstring ptr
	auxmap as zstring ptr
	minwidth as ulong
	maxwidth as ulong
	auxsize as ulong
	auxnext as ulong
	auxoffs(0 to 6) as ulong ptr
	chrinfo(0 to 0) as _GR_fontChrInfo
end type

type GrFont as _GR_font
extern GrFont_PC6x8 as GrFont
extern GrFont_PC8x8 as GrFont
extern GrFont_PC8x14 as GrFont
extern GrFont_PC8x16 as GrFont
extern GrDefaultFont alias "GrFont_PC8x14" as GrFont

declare function GrLoadFont(byval name as zstring ptr) as GrFont ptr
declare function GrLoadConvertedFont(byval name as zstring ptr, byval cvt as long, byval w as long, byval h as long, byval minch as long, byval maxch as long) as GrFont ptr
declare function GrBuildConvertedFont(byval from as const GrFont ptr, byval cvt as long, byval w as long, byval h as long, byval minch as long, byval maxch as long) as GrFont ptr
declare sub GrUnloadFont(byval font as GrFont ptr)
declare sub GrDumpFont(byval f as const GrFont ptr, byval CsymbolName as zstring ptr, byval fileName as zstring ptr)
declare sub GrDumpFnaFont(byval f as const GrFont ptr, byval fileName as zstring ptr)
declare sub GrSetFontPath(byval path_list as zstring ptr)
declare function GrFontCharPresent(byval font as const GrFont ptr, byval chr as long) as long
declare function GrFontCharWidth(byval font as const GrFont ptr, byval chr as long) as long
declare function GrFontCharHeight(byval font as const GrFont ptr, byval chr as long) as long
declare function GrFontCharBmpRowSize(byval font as const GrFont ptr, byval chr as long) as long
declare function GrFontCharBitmapSize(byval font as const GrFont ptr, byval chr as long) as long
declare function GrFontStringWidth(byval font as const GrFont ptr, byval text as any ptr, byval len as long, byval type as long) as long
declare function GrFontStringHeight(byval font as const GrFont ptr, byval text as any ptr, byval len as long, byval type as long) as long
declare function GrProportionalTextWidth(byval font as const GrFont ptr, byval text as const any ptr, byval len as long, byval type as long) as long
declare function GrBuildAuxiliaryBitmap(byval font as GrFont ptr, byval chr as long, byval dir as long, byval ul as long) as zstring ptr
declare function GrFontCharBitmap(byval font as const GrFont ptr, byval chr as long) as zstring ptr
declare function GrFontCharAuxBmp(byval font as GrFont ptr, byval chr as long, byval dir as long, byval ul as long) as zstring ptr

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
	txr_width as long
	txr_height as long
	txr_lineoffset as long
	txr_xpos as long
	txr_ypos as long
	txr_chrtype as byte
end type

declare function GrCharWidth(byval chr as long, byval opt as const GrTextOption ptr) as long
declare function GrCharHeight(byval chr as long, byval opt as const GrTextOption ptr) as long
declare sub GrCharSize(byval chr as long, byval opt as const GrTextOption ptr, byval w as long ptr, byval h as long ptr)
declare function GrStringWidth(byval text as any ptr, byval length as long, byval opt as const GrTextOption ptr) as long
declare function GrStringHeight(byval text as any ptr, byval length as long, byval opt as const GrTextOption ptr) as long
declare sub GrStringSize(byval text as any ptr, byval length as long, byval opt as const GrTextOption ptr, byval w as long ptr, byval h as long ptr)
declare sub GrDrawChar(byval chr as long, byval x as long, byval y as long, byval opt as const GrTextOption ptr)
declare sub GrDrawString(byval text as any ptr, byval length as long, byval x as long, byval y as long, byval opt as const GrTextOption ptr)
declare sub GrTextXY(byval x as long, byval y as long, byval text as zstring ptr, byval fg as GrColor, byval bg as GrColor)
declare sub GrDumpChar(byval chr as long, byval col as long, byval row as long, byval r as const GrTextRegion ptr)
declare sub GrDumpText(byval col as long, byval row as long, byval wdt as long, byval hgt as long, byval r as const GrTextRegion ptr)
declare sub GrDumpTextRegion(byval r as const GrTextRegion ptr)

type GrLineOption
	lno_color as GrColor
	lno_width as long
	lno_pattlen as long
	lno_dashpat as ubyte ptr
end type

declare sub GrCustomLine(byval x1 as long, byval y1 as long, byval x2 as long, byval y2 as long, byval o as const GrLineOption ptr)
declare sub GrCustomBox(byval x1 as long, byval y1 as long, byval x2 as long, byval y2 as long, byval o as const GrLineOption ptr)
declare sub GrCustomCircle(byval xc as long, byval yc as long, byval r as long, byval o as const GrLineOption ptr)
declare sub GrCustomEllipse(byval xc as long, byval yc as long, byval xa as long, byval ya as long, byval o as const GrLineOption ptr)
declare sub GrCustomCircleArc(byval xc as long, byval yc as long, byval r as long, byval start as long, byval end as long, byval style as long, byval o as const GrLineOption ptr)
declare sub GrCustomEllipseArc(byval xc as long, byval yc as long, byval xa as long, byval ya as long, byval start as long, byval end as long, byval style as long, byval o as const GrLineOption ptr)
declare sub GrCustomPolyLine(byval numpts as long, byval points as long ptr, byval o as const GrLineOption ptr)
declare sub GrCustomPolygon(byval numpts as long, byval points as long ptr, byval o as const GrLineOption ptr)

type _GR_bitmap
	bmp_ispixmap as long
	bmp_height as long
	bmp_data as zstring ptr
	bmp_fgcolor as GrColor
	bmp_bgcolor as GrColor
	bmp_memflags as long
end type

type GrBitmap as _GR_bitmap

type _GR_pixmap
	pxp_ispixmap as long
	pxp_width as long
	pxp_height as long
	pxp_oper as GrColor
	pxp_source as _GR_frame
end type

type GrPixmap as _GR_pixmap

union _GR_pattern
	gp_ispixmap as long
	gp_bitmap as GrBitmap
	gp_pixmap as GrPixmap
end union

type GrPattern as _GR_pattern
#define gp_bmp_data gp_bitmap.bmp_data
#define gp_bmp_height gp_bitmap.bmp_height
#define gp_bmp_fgcolor gp_bitmap.bmp_fgcolor
#define gp_bmp_bgcolor gp_bitmap.bmp_bgcolor
#define gp_pxp_width gp_pixmap.pxp_width
#define gp_pxp_height gp_pixmap.pxp_height
#define gp_pxp_oper gp_pixmap.pxp_oper
#define gp_pxp_source gp_pixmap.pxp_source

type GrLinePattern
	lnp_pattern as GrPattern ptr
	lnp_option as GrLineOption ptr
end type

declare function GrBuildPixmap(byval pixels as const zstring ptr, byval w as long, byval h as long, byval colors as const GrColorTableP) as GrPattern ptr
declare function GrBuildPixmapFromBits(byval bits as const zstring ptr, byval w as long, byval h as long, byval fgc as GrColor, byval bgc as GrColor) as GrPattern ptr
declare function GrConvertToPixmap(byval src as GrContext ptr) as GrPattern ptr
declare sub GrDestroyPattern(byval p as GrPattern ptr)
declare sub GrPatternedLine(byval x1 as long, byval y1 as long, byval x2 as long, byval y2 as long, byval lp as GrLinePattern ptr)
declare sub GrPatternedBox(byval x1 as long, byval y1 as long, byval x2 as long, byval y2 as long, byval lp as GrLinePattern ptr)
declare sub GrPatternedCircle(byval xc as long, byval yc as long, byval r as long, byval lp as GrLinePattern ptr)
declare sub GrPatternedEllipse(byval xc as long, byval yc as long, byval xa as long, byval ya as long, byval lp as GrLinePattern ptr)
declare sub GrPatternedCircleArc(byval xc as long, byval yc as long, byval r as long, byval start as long, byval end as long, byval style as long, byval lp as GrLinePattern ptr)
declare sub GrPatternedEllipseArc(byval xc as long, byval yc as long, byval xa as long, byval ya as long, byval start as long, byval end as long, byval style as long, byval lp as GrLinePattern ptr)
declare sub GrPatternedPolyLine(byval numpts as long, byval points as long ptr, byval lp as GrLinePattern ptr)
declare sub GrPatternedPolygon(byval numpts as long, byval points as long ptr, byval lp as GrLinePattern ptr)
declare sub GrPatternFilledPlot(byval x as long, byval y as long, byval p as GrPattern ptr)
declare sub GrPatternFilledLine(byval x1 as long, byval y1 as long, byval x2 as long, byval y2 as long, byval p as GrPattern ptr)
declare sub GrPatternFilledBox(byval x1 as long, byval y1 as long, byval x2 as long, byval y2 as long, byval p as GrPattern ptr)
declare sub GrPatternFilledCircle(byval xc as long, byval yc as long, byval r as long, byval p as GrPattern ptr)
declare sub GrPatternFilledEllipse(byval xc as long, byval yc as long, byval xa as long, byval ya as long, byval p as GrPattern ptr)
declare sub GrPatternFilledCircleArc(byval xc as long, byval yc as long, byval r as long, byval start as long, byval end as long, byval style as long, byval p as GrPattern ptr)
declare sub GrPatternFilledEllipseArc(byval xc as long, byval yc as long, byval xa as long, byval ya as long, byval start as long, byval end as long, byval style as long, byval p as GrPattern ptr)
declare sub GrPatternFilledConvexPolygon(byval numpts as long, byval points as long ptr, byval p as GrPattern ptr)
declare sub GrPatternFilledPolygon(byval numpts as long, byval points as long ptr, byval p as GrPattern ptr)
declare sub GrPatternFloodFill(byval x as long, byval y as long, byval border as GrColor, byval p as GrPattern ptr)
declare sub GrPatternDrawChar(byval chr as long, byval x as long, byval y as long, byval opt as const GrTextOption ptr, byval p as GrPattern ptr)
declare sub GrPatternDrawString(byval text as any ptr, byval length as long, byval x as long, byval y as long, byval opt as const GrTextOption ptr, byval p as GrPattern ptr)
declare sub GrPatternDrawStringExt(byval text as any ptr, byval length as long, byval x as long, byval y as long, byval opt as const GrTextOption ptr, byval p as GrPattern ptr)
type GrImage as GrPixmap
const GR_IMAGE_INVERSE_LR = &h01
const GR_IMAGE_INVERSE_TD = &h02
declare function GrImageBuild(byval pixels as const zstring ptr, byval w as long, byval h as long, byval colors as const GrColorTableP) as GrPixmap ptr
declare sub GrImageDestroy(byval i as GrPixmap ptr)
declare sub GrImageDisplay(byval x as long, byval y as long, byval i as GrPixmap ptr)
declare sub GrImageDisplayExt(byval x1 as long, byval y1 as long, byval x2 as long, byval y2 as long, byval i as GrPixmap ptr)
declare sub GrImageFilledBoxAlign(byval xo as long, byval yo as long, byval x1 as long, byval y1 as long, byval x2 as long, byval y2 as long, byval p as GrPixmap ptr)
declare sub GrImageHLineAlign(byval xo as long, byval yo as long, byval x as long, byval y as long, byval width as long, byval p as GrPixmap ptr)
declare sub GrImagePlotAlign(byval xo as long, byval yo as long, byval x as long, byval y as long, byval p as GrPixmap ptr)
declare function GrImageInverse(byval p as GrPixmap ptr, byval flag as long) as GrPixmap ptr
declare function GrImageStretch(byval p as GrPixmap ptr, byval nwidth as long, byval nheight as long) as GrPixmap ptr
declare function GrImageFromPattern(byval p as GrPattern ptr) as GrPixmap ptr
declare function GrImageFromContext(byval c as GrContext ptr) as GrPixmap ptr
declare function GrImageBuildUsedAsPattern(byval pixels as const zstring ptr, byval w as long, byval h as long, byval colors as const GrColorTableP) as GrPixmap ptr
declare function GrPatternFromImage(byval p as GrPixmap ptr) as GrPattern ptr
declare sub GrSetUserWindow(byval x1 as long, byval y1 as long, byval x2 as long, byval y2 as long)
declare sub GrGetUserWindow(byval x1 as long ptr, byval y1 as long ptr, byval x2 as long ptr, byval y2 as long ptr)
declare sub GrGetScreenCoord(byval x as long ptr, byval y as long ptr)
declare sub GrGetUserCoord(byval x as long ptr, byval y as long ptr)
declare sub GrUsrPlot(byval x as long, byval y as long, byval c as GrColor)
declare sub GrUsrLine(byval x1 as long, byval y1 as long, byval x2 as long, byval y2 as long, byval c as GrColor)
declare sub GrUsrHLine(byval x1 as long, byval x2 as long, byval y as long, byval c as GrColor)
declare sub GrUsrVLine(byval x as long, byval y1 as long, byval y2 as long, byval c as GrColor)
declare sub GrUsrBox(byval x1 as long, byval y1 as long, byval x2 as long, byval y2 as long, byval c as GrColor)
declare sub GrUsrFilledBox(byval x1 as long, byval y1 as long, byval x2 as long, byval y2 as long, byval c as GrColor)
declare sub GrUsrFramedBox(byval x1 as long, byval y1 as long, byval x2 as long, byval y2 as long, byval wdt as long, byval c as GrFBoxColors ptr)
declare sub GrUsrCircle(byval xc as long, byval yc as long, byval r as long, byval c as GrColor)
declare sub GrUsrEllipse(byval xc as long, byval yc as long, byval xa as long, byval ya as long, byval c as GrColor)
declare sub GrUsrCircleArc(byval xc as long, byval yc as long, byval r as long, byval start as long, byval end as long, byval style as long, byval c as GrColor)
declare sub GrUsrEllipseArc(byval xc as long, byval yc as long, byval xa as long, byval ya as long, byval start as long, byval end as long, byval style as long, byval c as GrColor)
declare sub GrUsrFilledCircle(byval xc as long, byval yc as long, byval r as long, byval c as GrColor)
declare sub GrUsrFilledEllipse(byval xc as long, byval yc as long, byval xa as long, byval ya as long, byval c as GrColor)
declare sub GrUsrFilledCircleArc(byval xc as long, byval yc as long, byval r as long, byval start as long, byval end as long, byval style as long, byval c as GrColor)
declare sub GrUsrFilledEllipseArc(byval xc as long, byval yc as long, byval xa as long, byval ya as long, byval start as long, byval end as long, byval style as long, byval c as GrColor)
declare sub GrUsrPolyLine(byval numpts as long, byval points as long ptr, byval c as GrColor)
declare sub GrUsrPolygon(byval numpts as long, byval points as long ptr, byval c as GrColor)
declare sub GrUsrFilledConvexPolygon(byval numpts as long, byval points as long ptr, byval c as GrColor)
declare sub GrUsrFilledPolygon(byval numpts as long, byval points as long ptr, byval c as GrColor)
declare sub GrUsrFloodFill(byval x as long, byval y as long, byval border as GrColor, byval c as GrColor)
declare function GrUsrPixel(byval x as long, byval y as long) as GrColor
declare function GrUsrPixelC(byval c as GrContext ptr, byval x as long, byval y as long) as GrColor
declare sub GrUsrCustomLine(byval x1 as long, byval y1 as long, byval x2 as long, byval y2 as long, byval o as const GrLineOption ptr)
declare sub GrUsrCustomBox(byval x1 as long, byval y1 as long, byval x2 as long, byval y2 as long, byval o as const GrLineOption ptr)
declare sub GrUsrCustomCircle(byval xc as long, byval yc as long, byval r as long, byval o as const GrLineOption ptr)
declare sub GrUsrCustomEllipse(byval xc as long, byval yc as long, byval xa as long, byval ya as long, byval o as const GrLineOption ptr)
declare sub GrUsrCustomCircleArc(byval xc as long, byval yc as long, byval r as long, byval start as long, byval end as long, byval style as long, byval o as const GrLineOption ptr)
declare sub GrUsrCustomEllipseArc(byval xc as long, byval yc as long, byval xa as long, byval ya as long, byval start as long, byval end as long, byval style as long, byval o as const GrLineOption ptr)
declare sub GrUsrCustomPolyLine(byval numpts as long, byval points as long ptr, byval o as const GrLineOption ptr)
declare sub GrUsrCustomPolygon(byval numpts as long, byval points as long ptr, byval o as const GrLineOption ptr)
declare sub GrUsrPatternedLine(byval x1 as long, byval y1 as long, byval x2 as long, byval y2 as long, byval lp as GrLinePattern ptr)
declare sub GrUsrPatternedBox(byval x1 as long, byval y1 as long, byval x2 as long, byval y2 as long, byval lp as GrLinePattern ptr)
declare sub GrUsrPatternedCircle(byval xc as long, byval yc as long, byval r as long, byval lp as GrLinePattern ptr)
declare sub GrUsrPatternedEllipse(byval xc as long, byval yc as long, byval xa as long, byval ya as long, byval lp as GrLinePattern ptr)
declare sub GrUsrPatternedCircleArc(byval xc as long, byval yc as long, byval r as long, byval start as long, byval end as long, byval style as long, byval lp as GrLinePattern ptr)
declare sub GrUsrPatternedEllipseArc(byval xc as long, byval yc as long, byval xa as long, byval ya as long, byval start as long, byval end as long, byval style as long, byval lp as GrLinePattern ptr)
declare sub GrUsrPatternedPolyLine(byval numpts as long, byval points as long ptr, byval lp as GrLinePattern ptr)
declare sub GrUsrPatternedPolygon(byval numpts as long, byval points as long ptr, byval lp as GrLinePattern ptr)
declare sub GrUsrPatternFilledPlot(byval x as long, byval y as long, byval p as GrPattern ptr)
declare sub GrUsrPatternFilledLine(byval x1 as long, byval y1 as long, byval x2 as long, byval y2 as long, byval p as GrPattern ptr)
declare sub GrUsrPatternFilledBox(byval x1 as long, byval y1 as long, byval x2 as long, byval y2 as long, byval p as GrPattern ptr)
declare sub GrUsrPatternFilledCircle(byval xc as long, byval yc as long, byval r as long, byval p as GrPattern ptr)
declare sub GrUsrPatternFilledEllipse(byval xc as long, byval yc as long, byval xa as long, byval ya as long, byval p as GrPattern ptr)
declare sub GrUsrPatternFilledCircleArc(byval xc as long, byval yc as long, byval r as long, byval start as long, byval end as long, byval style as long, byval p as GrPattern ptr)
declare sub GrUsrPatternFilledEllipseArc(byval xc as long, byval yc as long, byval xa as long, byval ya as long, byval start as long, byval end as long, byval style as long, byval p as GrPattern ptr)
declare sub GrUsrPatternFilledConvexPolygon(byval numpts as long, byval points as long ptr, byval p as GrPattern ptr)
declare sub GrUsrPatternFilledPolygon(byval numpts as long, byval points as long ptr, byval p as GrPattern ptr)
declare sub GrUsrPatternFloodFill(byval x as long, byval y as long, byval border as GrColor, byval p as GrPattern ptr)
declare sub GrUsrDrawChar(byval chr as long, byval x as long, byval y as long, byval opt as const GrTextOption ptr)
declare sub GrUsrDrawString(byval text as zstring ptr, byval length as long, byval x as long, byval y as long, byval opt as const GrTextOption ptr)
declare sub GrUsrTextXY(byval x as long, byval y as long, byval text as zstring ptr, byval fg as GrColor, byval bg as GrColor)

type _GR_cursor
	work as _GR_context
	xcord as long
	ycord as long
	xsize as long
	ysize as long
	xoffs as long
	yoffs as long
	xwork as long
	ywork as long
	xwpos as long
	ywpos as long
	displayed as long
end type

type GrCursor as _GR_cursor
declare function GrBuildCursor(byval pixels as zstring ptr, byval pitch as long, byval w as long, byval h as long, byval xo as long, byval yo as long, byval c as const GrColorTableP) as GrCursor ptr
declare sub GrDestroyCursor(byval cursor as GrCursor ptr)
declare sub GrDisplayCursor(byval cursor as GrCursor ptr)
declare sub GrEraseCursor(byval cursor as GrCursor ptr)
declare sub GrMoveCursor(byval cursor as GrCursor ptr, byval x as long, byval y as long)

const GR_M_MOTION = &h001
const GR_M_LEFT_DOWN = &h002
const GR_M_LEFT_UP = &h004
const GR_M_RIGHT_DOWN = &h008
const GR_M_RIGHT_UP = &h010
const GR_M_MIDDLE_DOWN = &h020
const GR_M_MIDDLE_UP = &h040
const GR_M_P4_DOWN = &h400
const GR_M_P4_UP = &h800
const GR_M_P5_DOWN = &h2000
const GR_M_P5_UP = &h4000
const GR_M_BUTTON_DOWN = (((GR_M_LEFT_DOWN or GR_M_MIDDLE_DOWN) or GR_M_RIGHT_DOWN) or GR_M_P4_DOWN) or GR_M_P5_DOWN
const GR_M_BUTTON_UP = (((GR_M_LEFT_UP or GR_M_MIDDLE_UP) or GR_M_RIGHT_UP) or GR_M_P4_UP) or GR_M_P5_UP
const GR_M_BUTTON_CHANGE = GR_M_BUTTON_UP or GR_M_BUTTON_DOWN
const GR_M_LEFT = &h01
const GR_M_RIGHT = &h02
const GR_M_MIDDLE = &h04
const GR_M_P4 = &h08
const GR_M_P5 = &h10
const GR_M_KEYPRESS = &h080
const GR_M_POLL = &h100
const GR_M_NOPAINT = &h200
const GR_COMMAND = &h1000
const GR_M_EVENT = ((GR_M_MOTION or GR_M_KEYPRESS) or GR_M_BUTTON_CHANGE) or GR_COMMAND
const GR_KB_RIGHTSHIFT = &h01
const GR_KB_LEFTSHIFT = &h02
const GR_KB_CTRL = &h04
const GR_KB_ALT = &h08
const GR_KB_SCROLLOCK = &h10
const GR_KB_NUMLOCK = &h20
const GR_KB_CAPSLOCK = &h40
const GR_KB_INSERT = &h80
const GR_KB_SHIFT = GR_KB_LEFTSHIFT or GR_KB_RIGHTSHIFT
const GR_M_CUR_NORMAL = 0
const GR_M_CUR_RUBBER = 1
const GR_M_CUR_LINE = 2
const GR_M_CUR_BOX = 3
const GR_M_QUEUE_SIZE = 128

type _GR_mouseEvent
	flags as long
	x as long
	y as long
	buttons as long
	key as long
	kbstat as long
	dtime as clong
end type

type GrMouseEvent as _GR_mouseEvent

type _GR_mouseInfo
	block as function(byval as GrContext ptr, byval as long, byval as long, byval as long, byval as long) as long
	unblock as sub(byval flags as long)
	uninit as sub()
	cursor as _GR_cursor ptr
	queue as _GR_mouseEvent ptr
	msstatus as long
	displayed as long
	blockflag as long
	docheck as long
	cursmode as long
	x1 as long
	y1 as long
	x2 as long
	y2 as long
	curscolor as GrColor
	owncursor as long
	xpos as long
	ypos as long
	xmin as long
	xmax as long
	ymin as long
	ymax as long
	spmult as long
	spdiv as long
	thresh as long
	accel as long
	moved as long
	qsize as long
	qlength as long
	qread as long
	qwrite as long
end type

extern GrMouseInfo as const _GR_mouseInfo const ptr
declare function GrMouseDetect() as long
declare sub GrMouseEventMode(byval dummy as long)
declare sub GrMouseInit()
declare sub GrMouseInitN(byval queue_size as long)
declare sub GrMouseUnInit()
declare sub GrMouseSetSpeed(byval spmult as long, byval spdiv as long)
declare sub GrMouseSetAccel(byval thresh as long, byval accel as long)
declare sub GrMouseSetLimits(byval x1 as long, byval y1 as long, byval x2 as long, byval y2 as long)
declare sub GrMouseGetLimits(byval x1 as long ptr, byval y1 as long ptr, byval x2 as long ptr, byval y2 as long ptr)
declare sub GrMouseWarp(byval x as long, byval y as long)
declare sub GrMouseEventEnable(byval enable_kb as long, byval enable_ms as long)
declare sub GrMouseGetEvent(byval flags as long, byval event as GrMouseEvent ptr)
declare sub GrMouseGetEventT(byval flags as long, byval event as GrMouseEvent ptr, byval timout_msecs as clong)
declare function GrMousePendingEvent() as long
declare function GrMouseGetCursor() as GrCursor ptr
declare sub GrMouseSetCursor(byval cursor as GrCursor ptr)
declare sub GrMouseSetColors(byval fg as GrColor, byval bg as GrColor)
declare sub GrMouseSetCursorMode(byval mode as long, ...)
declare sub GrMouseDisplayCursor()
declare sub GrMouseEraseCursor()
declare sub GrMouseUpdateCursor()
declare function GrMouseCursorIsDisplayed() as long
declare function GrMouseBlock(byval c as GrContext ptr, byval x1 as long, byval y1 as long, byval x2 as long, byval y2 as long) as long
declare sub GrMouseUnBlock(byval return_value_from_GrMouseBlock as long)

const PLAINPBMFORMAT = 1
const PLAINPGMFORMAT = 2
const PLAINPPMFORMAT = 3
const PBMFORMAT = 4
const PGMFORMAT = 5
const PPMFORMAT = 6

declare function GrSaveContextToPbm(byval grc as GrContext ptr, byval pbmfn as zstring ptr, byval docn as zstring ptr) as long
declare function GrSaveContextToPgm(byval grc as GrContext ptr, byval pgmfn as zstring ptr, byval docn as zstring ptr) as long
declare function GrSaveContextToPpm(byval grc as GrContext ptr, byval ppmfn as zstring ptr, byval docn as zstring ptr) as long
declare function GrLoadContextFromPnm(byval grc as GrContext ptr, byval pnmfn as zstring ptr) as long
declare function GrQueryPnm(byval pnmfn as zstring ptr, byval width as long ptr, byval height as long ptr, byval maxval as long ptr) as long
declare function GrLoadContextFromPnmBuffer(byval grc as GrContext ptr, byval buffer as const zstring ptr) as long
declare function GrQueryPnmBuffer(byval buffer as const zstring ptr, byval width as long ptr, byval height as long ptr, byval maxval as long ptr) as long
declare function GrPngSupport() as long
declare function GrSaveContextToPng(byval grc as GrContext ptr, byval pngfn as zstring ptr) as long
declare function GrLoadContextFromPng(byval grc as GrContext ptr, byval pngfn as zstring ptr, byval use_alpha as long) as long
declare function GrQueryPng(byval pngfn as zstring ptr, byval width as long ptr, byval height as long ptr) as long
declare function GrJpegSupport() as long
declare function GrLoadContextFromJpeg(byval grc as GrContext ptr, byval jpegfn as zstring ptr, byval scale as long) as long
declare function GrQueryJpeg(byval jpegfn as zstring ptr, byval width as long ptr, byval height as long ptr) as long
declare function GrSaveContextToJpeg(byval grc as GrContext ptr, byval jpegfn as zstring ptr, byval quality as long) as long
declare function GrSaveContextToGrayJpeg(byval grc as GrContext ptr, byval jpegfn as zstring ptr, byval quality as long) as long
declare sub GrResizeGrayMap(byval map as ubyte ptr, byval pitch as long, byval ow as long, byval oh as long, byval nw as long, byval nh as long)
declare function GrMatchString(byval pattern as const zstring ptr, byval strg as const zstring ptr) as long
declare sub GrSetWindowTitle(byval title as zstring ptr)
declare sub GrSleep(byval msec as long)
declare sub GrFlush()
declare function GrMsecTime() as clong
declare function SaveContextToTiff(byval cxt as GrContext ptr, byval tiffn as zstring ptr, byval compr as ulong, byval docn as zstring ptr) as long

end extern
