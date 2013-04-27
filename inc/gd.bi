'' GD Graphics Library 2.1.0 preview, from its Git commit 73cab5d8af96

#pragma once

#include once "crt/stdio.bi"

#ifdef __FB_WIN32__
	#ifdef NONDLL
		#inclib "bgd-static"
	#else
		#inclib "bgd"
	#endif
#else
	#define NONDLL 1
	#inclib "gd"
#endif

#inclib "jpeg"
#inclib "png"
#inclib "z"

#define GD_MAJOR_VERSION 2
#define GD_MINOR_VERSION 1
#define GD_RELEASE_VERSION 0
#define GD_EXTRA_VERSION "alpha"
#define GD_VERSION_STRING "2.1.0-alpha"

#ifdef NONDLL
	extern "C"
	#define BGD_EXPORT_DATA_PROT
#else
	extern "Windows"
	#define BGD_EXPORT_DATA_PROT import
#endif

type gdIOCtx
	getC	as function cdecl(byval as gdIOCtx ptr) as long
	getBuf	as function cdecl(byval as gdIOCtx ptr, byval as any ptr, byval as long) as long
	putC	as sub      cdecl(byval as gdIOCtx ptr, byval as long)
	putBuf	as function cdecl(byval as gdIOCtx ptr, byval as const any ptr, byval as long) as long
	seek	as function cdecl(byval as gdIOCtx ptr, byval as const long) as long
	tell	as function cdecl(byval as gdIOCtx ptr) as long
	gd_free	as sub      cdecl(byval as gdIOCtx ptr)
	data	as any ptr
end type

type gdIOCtxPtr as gdIOCtx ptr

declare sub gd_Putword cdecl alias "Putword"(byval w as long, byval ctx as gdIOCtx ptr)
declare sub gd_Putchar cdecl alias "Putchar"(byval c as long, byval ctx as gdIOCtx ptr)
declare sub gdPutC cdecl(byval c as const ubyte, byval ctx as gdIOCtx ptr)
declare function gdPutBuf cdecl(byval as const any ptr, byval as long, byval as gdIOCtx ptr) as long
declare sub gdPutWord cdecl(byval w as long, byval ctx as gdIOCtx ptr)
declare sub gdPutInt cdecl(byval w as long, byval ctx as gdIOCtx ptr)
declare function gdGetC cdecl(byval ctx as gdIOCtx ptr) as long
declare function gdGetBuf cdecl(byval as any ptr, byval as long, byval as gdIOCtx ptr) as long
declare function gdGetByte cdecl(byval result as long ptr, byval ctx as gdIOCtx ptr) as long
declare function gdGetWord cdecl(byval result as long ptr, byval ctx as gdIOCtx ptr) as long
declare function gdGetWordLSB cdecl(byval result as short ptr, byval ctx as gdIOCtx ptr) as long
declare function gdGetInt cdecl(byval result as long ptr, byval ctx as gdIOCtx ptr) as long
declare function gdGetIntLSB cdecl(byval result as long ptr, byval ctx as gdIOCtx ptr) as long
declare function gdSeek cdecl(byval ctx as gdIOCtx ptr, byval offset as const long) as long
declare function gdTell cdecl(byval ctx as gdIOCtx ptr) as long

#define gdMaxColors 256

#define gdAlphaMax 127
#define gdAlphaOpaque 0
#define gdAlphaTransparent 127
#define gdRedMax 255
#define gdGreenMax 255
#define gdBlueMax 255
#define gdTrueColorGetAlpha(c) (((c) and &h7F000000) shr 24)
#define gdTrueColorGetRed(c)   (((c) and &hFF0000) shr 16)
#define gdTrueColorGetGreen(c) (((c) and &h00FF00) shr 8)
#define gdTrueColorGetBlue(c)   ((c) and &h0000FF)

#define GD_TRUE 1
#define GD_FALSE 0

#define GD_EPSILON 1e-6
#ifndef M_PI
#define M_PI 3.14159265358979323846
#endif

declare function gdAlphaBlend(byval dest as long, byval src as long) as long

enum gdPaletteQuantizationMethod
	GD_QUANT_DEFAULT = 0
	GD_QUANT_JQUANT = 1
	GD_QUANT_NEUQUANT = 2
	GD_QUANT_LIQ = 3
end enum

enum gdInterpolationMethod
	GD_DEFAULT          = 0
	GD_BELL
	GD_BESSEL
	GD_BILINEAR_FIXED
	GD_BICUBIC
	GD_BICUBIC_FIXED
	GD_BLACKMAN
	GD_BOX
	GD_BSPLINE
	GD_CATMULLROM
	GD_GAUSSIAN
	GD_GENERALIZED_CUBIC
	GD_HERMITE
	GD_HAMMING
	GD_HANNING
	GD_MITCHELL
	GD_NEAREST_NEIGHBOUR
	GD_POWER
	GD_QUADRATIC
	GD_SINC
	GD_TRIANGLE
	GD_WEIGHTED4
	GD_METHOD_COUNT = 21
end enum

type interpolation_method as function cdecl(byval as double) as double

type gdImage
	pixels as ubyte ptr ptr
	sx as long
	sy as long
	colorsTotal as long
	red(0 to gdMaxColors-1) as long
	green(0 to gdMaxColors-1) as long
	blue(0 to gdMaxColors-1) as long
	open(0 to gdMaxColors-1) as long
	transparent as long
	polyInts as long ptr
	polyAllocated as long
	brush as gdImage ptr
	tile as gdImage ptr
	brushColorMap(0 to gdMaxColors-1) as long
	tileColorMap(0 to gdMaxColors-1) as long
	styleLength as long
	stylePos as long
	style as long ptr
	interlace as long
	thick as long
	alpha(0 to gdMaxColors-1) as long
	trueColor as long
	tpixels as long ptr ptr
	alphaBlendingFlag as long
	saveAlphaFlag as long
	AA as long
	AA_color as long
	AA_dont_blend as long
	cx1 as long
	cy1 as long
	cx2 as long
	cy2 as long
	res_x as ulong
	res_y as ulong
	paletteQuantizationMethod as long
	paletteQuantizationSpeed as long
	paletteQuantizationMinQuality as long
	paletteQuantizationMaxQuality as long
	interpolation_id as gdInterpolationMethod
	interpolation as interpolation_method
end type
type gdImagePtr as gdImage ptr

type gdPointF
	x as double
	y as double
end type
type gdPointFPtr as gdPointF ptr

type gdFont
	nchars as long
	offset as long
	w as long
	h as long
	data as byte ptr
end type
type gdFontPtr as gdFont ptr

type gdErrorMethod as sub cdecl(byval as long, byval as const zstring ptr, ...)

declare sub gdSetErrorMethod(byval as gdErrorMethod)
declare sub gdClearErrorMethod()

#define gdDashSize 4

#define gdStyled (-2)
#define gdBrushed (-3)
#define gdStyledBrushed (-4)
#define gdTiled (-5)
#define gdTransparent (-6)
#define gdAntiAliased (-7)

declare function gdImageCreate(byval sx as long, byval sy as long) as gdImagePtr
#define gdImageCreatePalette gdImageCreate
declare function gdImageCreateTrueColor(byval sx as long, byval sy as long) as gdImagePtr

declare function gdImageCreateFromPng(byval fd as FILE ptr) as gdImagePtr
declare function gdImageCreateFromPngCtx(byval in as gdIOCtxPtr) as gdImagePtr
declare function gdImageCreateFromPngPtr(byval size as long, byval data as any ptr) as gdImagePtr

declare function gdImageCreateFromGif(byval fd as FILE ptr) as gdImagePtr
declare function gdImageCreateFromGifCtx(byval in as gdIOCtxPtr) as gdImagePtr
declare function gdImageCreateFromGifPtr(byval size as long, byval data as any ptr) as gdImagePtr
declare function gdImageCreateFromWBMP(byval inFile as FILE ptr) as gdImagePtr
declare function gdImageCreateFromWBMPCtx(byval infile as gdIOCtx ptr) as gdImagePtr
declare function gdImageCreateFromWBMPPtr(byval size as long, byval data as any ptr) as gdImagePtr
declare function gdImageCreateFromJpeg(byval infile as FILE ptr) as gdImagePtr
declare function gdImageCreateFromJpegCtx(byval infile as gdIOCtx ptr) as gdImagePtr
declare function gdImageCreateFromJpegPtr(byval size as long, byval data as any ptr) as gdImagePtr
declare function gdImageCreateFromWebp(byval inFile as FILE ptr) as gdImagePtr
declare function gdImageCreateFromWebpPtr(byval size as long, byval data as any ptr) as gdImagePtr
declare function gdImageCreateFromWebpCtx(byval infile as gdIOCtx ptr) as gdImagePtr

declare function gdImageCreateFromTiff(byval inFile as FILE ptr) as gdImagePtr
declare function gdImageCreateFromTiffCtx(byval infile as gdIOCtx ptr) as gdImagePtr
declare function gdImageCreateFromTiffPtr(byval size as long, byval data as any ptr) as gdImagePtr

declare function gdImageCreateFromTga(byval fp as FILE ptr) as gdImagePtr
declare function gdImageCreateFromTgaCtx(byval ctx as gdIOCtx ptr) as gdImagePtr
declare function gdImageCreateFromTgaPtr(byval size as long, byval data as any ptr) as gdImagePtr

declare function gdImageCreateFromBmp(byval inFile as FILE ptr) as gdImagePtr
declare function gdImageCreateFromBmpPtr(byval size as long, byval data as any ptr) as gdImagePtr
declare function gdImageCreateFromBmpCtx(byval infile as gdIOCtxPtr) as gdImagePtr

type gdSource
	source as function cdecl(byval context as any ptr, byval buffer as zstring ptr, byval len as long) as long
	context as any ptr
end type
type gdSourcePtr as gdSource ptr

declare function gdImageCreateFromPngSource(byval in as gdSourcePtr) as gdImagePtr
declare function gdImageCreateFromGd(byval in as FILE ptr) as gdImagePtr
declare function gdImageCreateFromGdCtx(byval in as gdIOCtxPtr) as gdImagePtr
declare function gdImageCreateFromGdPtr(byval size as long, byval data as any ptr) as gdImagePtr
declare function gdImageCreateFromGd2(byval in as FILE ptr) as gdImagePtr
declare function gdImageCreateFromGd2Ctx(byval in as gdIOCtxPtr) as gdImagePtr
declare function gdImageCreateFromGd2Ptr(byval size as long, byval data as any ptr) as gdImagePtr
declare function gdImageCreateFromGd2Part(byval in as FILE ptr, byval srcx as long, byval srcy as long, byval w as long, byval h as long) as gdImagePtr
declare function gdImageCreateFromGd2PartCtx(byval in as gdIOCtxPtr, byval srcx as long, byval srcy as long, byval w as long, byval h as long) as gdImagePtr
declare function gdImageCreateFromGd2PartPtr(byval size as long, byval data as any ptr, byval srcx as long, byval srcy as long, byval w as long, byval h as long) as gdImagePtr
declare function gdImageCreateFromXbm(byval in as FILE ptr) as gdImagePtr
declare function gdImageCreateFromXpm(byval filename as zstring ptr) as gdImagePtr
declare sub gdImageDestroy(byval im as gdImagePtr)
declare sub gdImageSetPixel(byval im as gdImagePtr, byval x as long, byval y as long, byval color as long)
declare function gdImageGetPixel(byval im as gdImagePtr, byval x as long, byval y as long) as long
declare function gdImageGetTrueColorPixel(byval im as gdImagePtr, byval x as long, byval y as long) as long
declare sub gdImageAABlend(byval im as gdImagePtr)
declare sub gdImageLine(byval im as gdImagePtr, byval x1 as long, byval y1 as long, byval x2 as long, byval y2 as long, byval color as long)
declare sub gdImageDashedLine(byval im as gdImagePtr, byval x1 as long, byval y1 as long, byval x2 as long, byval y2 as long, byval color as long)
declare sub gdImageRectangle(byval im as gdImagePtr, byval x1 as long, byval y1 as long, byval x2 as long, byval y2 as long, byval color as long)
declare sub gdImageFilledRectangle(byval im as gdImagePtr, byval x1 as long, byval y1 as long, byval x2 as long, byval y2 as long, byval color as long)
declare sub gdImageSetClip(byval im as gdImagePtr, byval x1 as long, byval y1 as long, byval x2 as long, byval y2 as long)
declare sub gdImageGetClip(byval im as gdImagePtr, byval x1P as long ptr, byval y1P as long ptr, byval x2P as long ptr, byval y2P as long ptr)
declare sub gdImageSetResolution(byval im as gdImagePtr, byval res_x as const ulong, byval res_y as const ulong)
declare function gdImageBoundsSafe(byval im as gdImagePtr, byval x as long, byval y as long) as long
declare sub gdImageChar(byval im as gdImagePtr, byval f as gdFontPtr, byval x as long, byval y as long, byval c as long, byval color as long)
declare sub gdImageCharUp(byval im as gdImagePtr, byval f as gdFontPtr, byval x as long, byval y as long, byval c as long, byval color as long)
declare sub gdImageString(byval im as gdImagePtr, byval f as gdFontPtr, byval x as long, byval y as long, byval s as ubyte ptr, byval color as long)
declare sub gdImageStringUp(byval im as gdImagePtr, byval f as gdFontPtr, byval x as long, byval y as long, byval s as ubyte ptr, byval color as long)
declare sub gdImageString16(byval im as gdImagePtr, byval f as gdFontPtr, byval x as long, byval y as long, byval s as ushort ptr, byval color as long)
declare sub gdImageStringUp16(byval im as gdImagePtr, byval f as gdFontPtr, byval x as long, byval y as long, byval s as ushort ptr, byval color as long)
declare function gdFontCacheSetup() as long
declare sub gdFontCacheShutdown()
declare sub gdFreeFontCache()
declare function gdImageStringTTF(byval im as gdImage ptr, byval brect as long ptr, byval fg as long, byval fontlist as zstring ptr, byval ptsize as double, byval angle as double, byval x as long, byval y as long, byval string as zstring ptr) as zstring ptr
declare function gdImageStringFT(byval im as gdImage ptr, byval brect as long ptr, byval fg as long, byval fontlist as zstring ptr, byval ptsize as double, byval angle as double, byval x as long, byval y as long, byval string as zstring ptr) as zstring ptr

type gdFTStringExtra
	flags as long
	linespacing as double
	charmap as long
	hdpi as long
	vdpi as long
	xshow as zstring ptr
	fontpath as zstring ptr
end type
type gdFTStringExtraPtr as gdFTStringExtra ptr

#define gdFTEX_LINESPACE 1
#define gdFTEX_CHARMAP 2
#define gdFTEX_RESOLUTION 4
#define gdFTEX_DISABLE_KERNING 8
#define gdFTEX_XSHOW 16
#define gdFTEX_FONTPATHNAME 32
#define gdFTEX_FONTCONFIG 64
#define gdFTEX_RETURNFONTPATHNAME 128

declare function gdFTUseFontConfig(byval flag as long) as long

#define gdFTEX_Unicode 0
#define gdFTEX_Shift_JIS 1
#define gdFTEX_Big5 2
#define gdFTEX_Adobe_Custom 3

declare function gdImageStringFTEx(byval im as gdImage ptr, byval brect as long ptr, byval fg as long, byval fontlist as zstring ptr, byval ptsize as double, byval angle as double, byval x as long, byval y as long, byval string as zstring ptr, byval strex as gdFTStringExtraPtr) as zstring ptr

type gdPoint
	x as long
	y as long
end type
type gdPointPtr as gdPoint ptr

type gdRect
	x as long
	y as long
	width as long
	height as long
end type
type gdRectPtr as gdRect ptr

declare sub gdImagePolygon(byval im as gdImagePtr, byval p as gdPointPtr, byval n as long, byval c as long)
declare sub gdImageOpenPolygon(byval im as gdImagePtr, byval p as gdPointPtr, byval n as long, byval c as long)
declare sub gdImageFilledPolygon(byval im as gdImagePtr, byval p as gdPointPtr, byval n as long, byval c as long)
declare function gdImageColorAllocate(byval im as gdImagePtr, byval r as long, byval g as long, byval b as long) as long
declare function gdImageColorAllocateAlpha(byval im as gdImagePtr, byval r as long, byval g as long, byval b as long, byval a as long) as long
declare function gdImageColorClosest(byval im as gdImagePtr, byval r as long, byval g as long, byval b as long) as long
declare function gdImageColorClosestAlpha(byval im as gdImagePtr, byval r as long, byval g as long, byval b as long, byval a as long) as long
declare function gdImageColorClosestHWB(byval im as gdImagePtr, byval r as long, byval g as long, byval b as long) as long
declare function gdImageColorExact(byval im as gdImagePtr, byval r as long, byval g as long, byval b as long) as long
declare function gdImageColorExactAlpha(byval im as gdImagePtr, byval r as long, byval g as long, byval b as long, byval a as long) as long
declare function gdImageColorResolve(byval im as gdImagePtr, byval r as long, byval g as long, byval b as long) as long
declare function gdImageColorResolveAlpha(byval im as gdImagePtr, byval r as long, byval g as long, byval b as long, byval a as long) as long

#define gdTrueColor(r, g, b) (((r) shl 16) + ((g) shl 8) +  (b))
#define gdTrueColorAlpha(r, g, b, a) (((a) shl 24) + ((r) shl 16) + ((g) shl 8) + (b))

declare sub gdImageColorDeallocate(byval im as gdImagePtr, byval color as long)
declare function gdImageCreatePaletteFromTrueColor(byval im as gdImagePtr, byval ditherFlag as long, byval colorsWanted as long) as gdImagePtr
declare function gdImageTrueColorToPalette(byval im as gdImagePtr, byval ditherFlag as long, byval colorsWanted as long) as long
declare function gdImagePaletteToTrueColor(byval src as gdImagePtr) as long
declare function gdImageTrueColorToPaletteSetMethod(byval im as gdImagePtr, byval method as long, byval speed as long) as long
declare sub gdImageTrueColorToPaletteSetQuality(byval im as gdImagePtr, byval min_quality as long, byval max_quality as long)
declare sub gdImageColorTransparent(byval im as gdImagePtr, byval color as long)
declare sub gdImagePaletteCopy(byval dst as gdImagePtr, byval src as gdImagePtr)

type gdCallbackImageColor as function cdecl(byval im as gdImagePtr, byval src as long) as long

declare function gdImageColorReplace(byval im as gdImagePtr, byval src as long, byval dst as long) as long
declare function gdImageColorReplaceThreshold(byval im as gdImagePtr, byval src as long, byval dst as long, byval threshold as single) as long
declare function gdImageColorReplaceArray(byval im as gdImagePtr, byval len as long, byval src as long ptr, byval dst as long ptr) as long
declare function gdImageColorReplaceCallback(byval im as gdImagePtr, byval callback as gdCallbackImageColor) as long
declare sub gdImageGif(byval im as gdImagePtr, byval out as FILE ptr)
declare sub gdImagePng(byval im as gdImagePtr, byval out as FILE ptr)
declare sub gdImagePngCtx(byval im as gdImagePtr, byval out as gdIOCtx ptr)
declare sub gdImageGifCtx(byval im as gdImagePtr, byval out as gdIOCtx ptr)
declare sub gdImageTiff(byval im as gdImagePtr, byval outFile as FILE ptr)
declare function gdImageTiffPtr(byval im as gdImagePtr, byval size as long ptr) as any ptr
declare sub gdImageTiffCtx(byval image as gdImagePtr, byval out as gdIOCtx ptr)
declare function gdImageBmpPtr(byval im as gdImagePtr, byval size as long ptr, byval compression as long) as any ptr
declare sub gdImageBmp(byval im as gdImagePtr, byval outFile as FILE ptr, byval compression as long)
declare sub gdImageBmpCtx(byval im as gdImagePtr, byval out as gdIOCtxPtr, byval compression as long)
declare sub gdImagePngEx(byval im as gdImagePtr, byval out as FILE ptr, byval level as long)
declare sub gdImagePngCtxEx(byval im as gdImagePtr, byval out as gdIOCtx ptr, byval level as long)
declare sub gdImageWBMP(byval image as gdImagePtr, byval fg as long, byval out as FILE ptr)
declare sub gdImageWBMPCtx(byval image as gdImagePtr, byval fg as long, byval out as gdIOCtx ptr)
declare sub gdFree(byval m as any ptr)
declare function gdImageWBMPPtr(byval im as gdImagePtr, byval size as long ptr, byval fg as long) as any ptr
declare sub gdImageJpeg(byval im as gdImagePtr, byval out as FILE ptr, byval quality as long)
declare sub gdImageJpegCtx(byval im as gdImagePtr, byval out as gdIOCtx ptr, byval quality as long)
declare function gdImageJpegPtr(byval im as gdImagePtr, byval size as long ptr, byval quality as long) as any ptr
declare sub gdImageWebpEx(byval im as gdImagePtr, byval outFile as FILE ptr, byval quantization as long)
declare sub gdImageWebp(byval im as gdImagePtr, byval outFile as FILE ptr)
declare function gdImageWebpPtr(byval im as gdImagePtr, byval size as long ptr) as any ptr
declare function gdImageWebpPtrEx(byval im as gdImagePtr, byval size as long ptr, byval quantization as long) as any ptr
declare sub gdImageWebpCtx(byval im as gdImagePtr, byval outfile as gdIOCtx ptr, byval quantization as long)

enum
	gdDisposalUnknown
	gdDisposalNone
	gdDisposalRestoreBackground
	gdDisposalRestorePrevious
end enum

declare sub gdImageGifAnimBegin(byval im as gdImagePtr, byval outFile as FILE ptr, byval GlobalCM as long, byval Loops as long)
declare sub gdImageGifAnimAdd(byval im as gdImagePtr, byval outFile as FILE ptr, byval LocalCM as long, byval LeftOfs as long, byval TopOfs as long, byval Delay as long, byval Disposal as long, byval previm as gdImagePtr)
declare sub gdImageGifAnimEnd(byval outFile as FILE ptr)
declare sub gdImageGifAnimBeginCtx(byval im as gdImagePtr, byval out as gdIOCtx ptr, byval GlobalCM as long, byval Loops as long)
declare sub gdImageGifAnimAddCtx(byval im as gdImagePtr, byval out as gdIOCtx ptr, byval LocalCM as long, byval LeftOfs as long, byval TopOfs as long, byval Delay as long, byval Disposal as long, byval previm as gdImagePtr)
declare sub gdImageGifAnimEndCtx(byval out as gdIOCtx ptr)
declare function gdImageGifAnimBeginPtr(byval im as gdImagePtr, byval size as long ptr, byval GlobalCM as long, byval Loops as long) as any ptr
declare function gdImageGifAnimAddPtr(byval im as gdImagePtr, byval size as long ptr, byval LocalCM as long, byval LeftOfs as long, byval TopOfs as long, byval Delay as long, byval Disposal as long, byval previm as gdImagePtr) as any ptr
declare function gdImageGifAnimEndPtr(byval size as long ptr) as any ptr

type gdSink
	sink as function cdecl(byval context as any ptr, byval buffer as const zstring ptr, byval len as long) as long
	context as any ptr
end type
type gdSinkPtr as gdSink ptr

declare sub gdImagePngToSink(byval im as gdImagePtr, byval out as gdSinkPtr)
declare sub gdImageGd(byval im as gdImagePtr, byval out as FILE ptr)
declare sub gdImageGd2(byval im as gdImagePtr, byval out as FILE ptr, byval cs as long, byval fmt as long)
declare function gdImageGifPtr(byval im as gdImagePtr, byval size as long ptr) as any ptr
declare function gdImagePngPtr(byval im as gdImagePtr, byval size as long ptr) as any ptr
declare function gdImagePngPtrEx(byval im as gdImagePtr, byval size as long ptr, byval level as long) as any ptr
declare function gdImageGdPtr(byval im as gdImagePtr, byval size as long ptr) as any ptr
declare function gdImageGd2Ptr(byval im as gdImagePtr, byval cs as long, byval fmt as long, byval size as long ptr) as any ptr

#define gdArc 0
#define gdPie gdArc
#define gdChord 1
#define gdNoFill 2
#define gdEdged 4

declare sub gdImageFilledArc(byval im as gdImagePtr, byval cx as long, byval cy as long, byval w as long, byval h as long, byval s as long, byval e as long, byval color as long, byval style as long)
declare sub gdImageArc(byval im as gdImagePtr, byval cx as long, byval cy as long, byval w as long, byval h as long, byval s as long, byval e as long, byval color as long)
declare sub gdImageEllipse(byval im as gdImagePtr, byval cx as long, byval cy as long, byval w as long, byval h as long, byval color as long)
declare sub gdImageFilledEllipse(byval im as gdImagePtr, byval cx as long, byval cy as long, byval w as long, byval h as long, byval color as long)
declare sub gdImageFillToBorder(byval im as gdImagePtr, byval x as long, byval y as long, byval border as long, byval color as long)
declare sub gdImageFill(byval im as gdImagePtr, byval x as long, byval y as long, byval color as long)
declare sub gdImageCopy(byval dst as gdImagePtr, byval src as gdImagePtr, byval dstX as long, byval dstY as long, byval srcX as long, byval srcY as long, byval w as long, byval h as long)
declare sub gdImageCopyMerge(byval dst as gdImagePtr, byval src as gdImagePtr, byval dstX as long, byval dstY as long, byval srcX as long, byval srcY as long, byval w as long, byval h as long, byval pct as long)
declare sub gdImageCopyMergeGray(byval dst as gdImagePtr, byval src as gdImagePtr, byval dstX as long, byval dstY as long, byval srcX as long, byval srcY as long, byval w as long, byval h as long, byval pct as long)
declare sub gdImageCopyResized(byval dst as gdImagePtr, byval src as gdImagePtr, byval dstX as long, byval dstY as long, byval srcX as long, byval srcY as long, byval dstW as long, byval dstH as long, byval srcW as long, byval srcH as long)
declare sub gdImageCopyResampled(byval dst as gdImagePtr, byval src as gdImagePtr, byval dstX as long, byval dstY as long, byval srcX as long, byval srcY as long, byval dstW as long, byval dstH as long, byval srcW as long, byval srcH as long)
declare sub gdImageCopyRotated(byval dst as gdImagePtr, byval src as gdImagePtr, byval dstX as double, byval dstY as double, byval srcX as long, byval srcY as long, byval srcWidth as long, byval srcHeight as long, byval angle as long)
declare sub gdImageSetBrush(byval im as gdImagePtr, byval brush as gdImagePtr)
declare sub gdImageSetTile(byval im as gdImagePtr, byval tile as gdImagePtr)
declare sub gdImageSetAntiAliased(byval im as gdImagePtr, byval c as long)
declare sub gdImageSetAntiAliasedDontBlend(byval im as gdImagePtr, byval c as long, byval dont_blend as long)
declare sub gdImageSetStyle(byval im as gdImagePtr, byval style as long ptr, byval noOfPixels as long)
declare sub gdImageSetThickness(byval im as gdImagePtr, byval thickness as long)
declare sub gdImageInterlace(byval im as gdImagePtr, byval interlaceArg as long)
declare sub gdImageAlphaBlending(byval im as gdImagePtr, byval alphaBlendingArg as long)
declare sub gdImageSaveAlpha(byval im as gdImagePtr, byval saveAlphaArg as long)
declare function gdImageNeuQuant(byval im as gdImagePtr, byval max_color as const long, byval sample_factor as long) as gdImagePtr

enum gdPixelateMode
	GD_PIXELATE_UPPERLEFT
	GD_PIXELATE_AVERAGE
end enum

declare function gdImagePixelate(byval im as gdImagePtr, byval block_size as long, byval mode as const ulong) as long

type gdScatter
	sub as long
	plus as long
	num_colors as ulong
	colors as long ptr
	seed as ulong
end type
type gdScatterPtr as gdScatter ptr

declare function gdImageScatter(byval im as gdImagePtr, byval sub as long, byval plus as long) as long
declare function gdImageScatterColor(byval im as gdImagePtr, byval sub as long, byval plus as long, byval colors as long ptr, byval num_colors as ulong) as long
declare function gdImageScatterEx(byval im as gdImagePtr, byval s as gdScatterPtr) as long
declare function gdImageSmooth(byval im as gdImagePtr, byval weight as single) as long
declare function gdImageMeanRemoval(byval im as gdImagePtr) as long
declare function gdImageEmboss(byval im as gdImagePtr) as long
declare function gdImageGaussianBlur(byval im as gdImagePtr) as long
declare function gdImageEdgeDetectQuick(byval src as gdImagePtr) as long
declare function gdImageSelectiveBlur(byval src as gdImagePtr) as long
declare function gdImageConvolution(byval src as gdImagePtr, byval filter as single ptr, byval filter_div as single, byval offset as single) as long
declare function gdImageColor(byval src as gdImagePtr, byval red as const long, byval green as const long, byval blue as const long, byval alpha as const long) as long
declare function gdImageContrast(byval src as gdImagePtr, byval contrast as double) as long
declare function gdImageBrightness(byval src as gdImagePtr, byval brightness as long) as long
declare function gdImageGrayScale(byval src as gdImagePtr) as long
declare function gdImageNegate(byval src as gdImagePtr) as long

#define gdImageTrueColor(im) ((im)->trueColor)
#define gdImageSX(im) ((im)->sx)
#define gdImageSY(im) ((im)->sy)
#define gdImageColorsTotal(im) ((im)->colorsTotal)
#define gdImageRed(im, c)   iif((im)->trueColor, gdTrueColorGetRed(c)  , (im)->red(c))
#define gdImageGreen(im, c) iif((im)->trueColor, gdTrueColorGetGreen(c), (im)->green(c))
#define gdImageBlue(im, c)  iif((im)->trueColor, gdTrueColorGetBlue(c) , (im)->blue(c))
#define gdImageAlpha(im, c) iif((im)->trueColor, gdTrueColorGetAlpha(c), (im)->alpha(c))
#define gdImageGetTransparent(im) ((im)->transparent)
#define gdImageGetInterlaced(im) ((im)->interlace)
#define gdImagePalettePixel(im, x, y) (im)->pixels[(y)][(x)]
#define gdImageTrueColorPixel(im, x, y) (im)->tpixels[(y)][(x)]
#define gdImageResolutionX(im) (im)->res_x
#define gdImageResolutionY(im) (im)->res_y

declare function gdNewFileCtx(byval as FILE ptr) as gdIOCtx ptr
declare function gdNewDynamicCtx(byval size as long, byval data as any ptr) as gdIOCtx ptr
declare function gdNewDynamicCtxEx(byval size as long, byval data as any ptr, byval freeFlag as long) as gdIOCtx ptr
declare function gdNewSSCtx(byval in as gdSourcePtr, byval out as gdSinkPtr) as gdIOCtx ptr
declare function gdDPExtractData(byval ctx as gdIOCtx ptr, byval size as long ptr) as any ptr

#define GD2_CHUNKSIZE 128
#define GD2_CHUNKSIZE_MIN 64
#define GD2_CHUNKSIZE_MAX 4096
#define GD2_VERS 2
#define GD2_ID "gd2"
#define GD2_FMT_RAW 1
#define GD2_FMT_COMPRESSED 2

declare function gdImageCompare(byval im1 as gdImagePtr, byval im2 as gdImagePtr) as long
declare sub gdImageFlipHorizontal(byval im as gdImagePtr)
declare sub gdImageFlipVertical(byval im as gdImagePtr)
declare sub gdImageFlipBoth(byval im as gdImagePtr)

#define GD_FLIP_HORINZONTAL 1
#define GD_FLIP_VERTICAL 2
#define GD_FLIP_BOTH 3

enum gdCropMode
	GD_CROP_DEFAULT = 0
	GD_CROP_TRANSPARENT
	GD_CROP_BLACK
	GD_CROP_WHITE
	GD_CROP_SIDES
	GD_CROP_THRESHOLD
end enum

declare function gdImageCrop(byval src as gdImagePtr, byval crop as const gdRect ptr) as gdImagePtr
declare function gdImageCropAuto(byval im as gdImagePtr, byval mode as const ulong) as gdImagePtr
declare function gdImageCropThreshold(byval im as gdImagePtr, byval color as const ulong, byval threshold as const single) as gdImagePtr
declare function gdImageSetInterpolationMethod cdecl(byval im as gdImagePtr, byval id as gdInterpolationMethod) as long
declare function gdImageScaleBilinear cdecl(byval im as gdImagePtr, byval new_width as const ulong, byval new_height as const ulong) as gdImagePtr
declare function gdImageScaleBicubic cdecl(byval src_img as gdImagePtr, byval new_width as const ulong, byval new_height as const ulong) as gdImagePtr
declare function gdImageScaleBicubicFixed cdecl(byval src as gdImagePtr, byval width as const ulong, byval height as const ulong) as gdImagePtr
declare function gdImageScaleNearestNeighbour cdecl(byval im as gdImagePtr, byval width as const ulong, byval height as const ulong) as gdImagePtr
declare function gdImageScaleTwoPass cdecl(byval pOrigImage as const gdImagePtr, byval uOrigWidth as const ulong, byval uOrigHeight as const ulong, byval uNewWidth as const ulong, byval uNewHeight as const ulong) as gdImagePtr
declare function gdImageScale(byval src as const gdImagePtr, byval new_width as const ulong, byval new_height as const ulong) as gdImagePtr

declare function gdImageRotate90 cdecl(byval src as gdImagePtr, byval ignoretransparent as long) as gdImagePtr
declare function gdImageRotate180 cdecl(byval src as gdImagePtr, byval ignoretransparent as long) as gdImagePtr
declare function gdImageRotate270 cdecl(byval src as gdImagePtr, byval ignoretransparent as long) as gdImagePtr
declare function gdImageRotateNearestNeighbour cdecl(byval src as gdImagePtr, byval degrees as const single, byval bgColor as const long) as gdImagePtr
declare function gdImageRotateBilinear cdecl(byval src as gdImagePtr, byval degrees as const single, byval bgColor as const long) as gdImagePtr
declare function gdImageRotateBicubicFixed cdecl(byval src as gdImagePtr, byval degrees as const single, byval bgColor as const long) as gdImagePtr
declare function gdImageRotateGeneric cdecl(byval src as gdImagePtr, byval degrees as const single, byval bgColor as const long) as gdImagePtr
declare function gdImageRotateInterpolated(byval src as const gdImagePtr, byval angle as const single, byval bgcolor as long) as gdImagePtr

enum gdAffineStandardMatrix
	GD_AFFINE_TRANSLATE = 0
	GD_AFFINE_SCALE
	GD_AFFINE_ROTATE
	GD_AFFINE_SHEAR_HORIZONTAL
	GD_AFFINE_SHEAR_VERTICAL
end enum

declare function gdAffineApplyToPointF(byval dst as gdPointFPtr, byval src as const gdPointFPtr, byval affine as const double ptr) as long
declare function gdAffineInvert(byval dst as double ptr, byval src as const double ptr) as long
declare function gdAffineFlip(byval dst_affine as double ptr, byval src_affine as const double ptr, byval flip_h as const long, byval flip_v as const long) as long
declare function gdAffineConcat(byval dst as double ptr, byval m1 as const double ptr, byval m2 as const double ptr) as long
declare function gdAffineIdentity(byval dst as double ptr) as long
declare function gdAffineScale(byval dst as double ptr, byval scale_x as const double, byval scale_y as const double) as long
declare function gdAffineRotate(byval dst as double ptr, byval angle as const double) as long
declare function gdAffineShearHorizontal(byval dst as double ptr, byval angle as const double) as long
declare function gdAffineShearVertical(byval dst as double ptr, byval angle as const double) as long
declare function gdAffineTranslate(byval dst as double ptr, byval offset_x as const double, byval offset_y as const double) as long
declare function gdAffineExpansion(byval src as const double ptr) as double
declare function gdAffineRectilinear(byval src as const double ptr) as long
declare function gdAffineEqual(byval matrix1 as const double ptr, byval matrix2 as const double ptr) as long
declare function gdTransformAffineGetImage(byval dst as gdImagePtr ptr, byval src as const gdImagePtr, byval src_area as gdRectPtr, byval affine as const double ptr) as long
declare function gdTransformAffineCopy(byval dst as gdImagePtr, byval dst_x as long, byval dst_y as long, byval src as const gdImagePtr, byval src_region as gdRectPtr, byval affine as const double ptr) as long
declare function gdTransformAffineBoundingBox(byval src as gdRectPtr, byval affine as const double ptr, byval bbox as gdRectPtr) as long

#define GD_CMP_IMAGE 1
#define GD_CMP_NUM_COLORS 2
#define GD_CMP_COLOR 4
#define GD_CMP_SIZE_X 8
#define GD_CMP_SIZE_Y 16
#define GD_CMP_TRANSPARENT 32
#define GD_CMP_BACKGROUND 64
#define GD_CMP_INTERLACE 128
#define GD_CMP_TRUECOLOR 256
#define GD_RESOLUTION 96

declare function gdImageSquareToCircle(byval im as gdImagePtr, byval radius as long) as gdImagePtr
declare function gdImageStringFTCircle(byval im as gdImagePtr, byval cx as long, byval cy as long, byval radius as double, byval textRadius as double, byval fillPortion as double, byval font as zstring ptr, byval points as double, byval top as zstring ptr, byval bottom as zstring ptr, byval fgcolor as long) as zstring ptr
declare sub gdImageSharpen(byval im as gdImagePtr, byval pct as long)

extern BGD_EXPORT_DATA_PROT gdFontTiny as gdFontPtr
extern BGD_EXPORT_DATA_PROT gdFontSmall as gdFontPtr
extern BGD_EXPORT_DATA_PROT gdFontMediumBold as gdFontPtr
extern BGD_EXPORT_DATA_PROT gdFontLarge as gdFontPtr
extern BGD_EXPORT_DATA_PROT gdFontGiant as gdFontPtr

declare function gdFontGetTiny() as gdFontPtr
declare function gdFontGetSmall() as gdFontPtr
declare function gdFontGetMediumBold() as gdFontPtr
declare function gdFontGetLarge() as gdFontPtr
declare function gdFontGetGiant() as gdFontPtr

end extern

extern "C"

type gdCacheTestFn_t as function(byval userdata as any ptr, byval keydata as any ptr) as long
type gdCacheFetchFn_t as function(byval error as zstring ptr ptr, byval keydata as any ptr) as any ptr
type gdCacheReleaseFn_t as sub(byval userdata as any ptr)

type gdCache_element_t
	next as gdCache_element_t ptr
	userdata as any ptr
end type

type gdCache_head_t
	mru as gdCache_element_t ptr
	size as long
	error as zstring ptr
	gdCacheTest as gdCacheTestFn_t
	gdCacheFetch as gdCacheFetchFn_t
	gdCacheRelease as gdCacheReleaseFn_t
end type

declare function gdCacheCreate(byval size as long, byval gdCacheTest as gdCacheTestFn_t, byval gdCacheFetch as gdCacheFetchFn_t, byval gdCacheRelease as gdCacheReleaseFn_t) as gdCache_head_t ptr '' function templates 
declare sub gdCacheDelete(byval head as gdCache_head_t ptr)
declare function gdCacheGet(byval head as gdCache_head_t ptr, byval keydata as any ptr) as any ptr

end extern
